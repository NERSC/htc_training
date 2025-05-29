Basic (distributed)
===================

Let's repeat the same thing again from the previous section but this time
with many tasks (100k) across many nodes.

>[!NOTE]
> We can't commit 100k x2 output files to the repository so we won't
> include that here but instead just show the steps to generate the input.

Run the `make_tasks.sh` script to generate the input file.
This will include a similar set of tasks and only one that will "fail".

```sh
./make_tasks.sh > task.in
```

You can use `wc -l task.in` to confirm (as well as `head task.in`).
And confirm the one pesky "fail" with `grep false task.in`.

We'll cover configuration and using the database soon.
For now, let's enable more verbose logging to see what's going on.
As mentioned before, we can use an environment variable to enable
certain behavior, in this case `HYPERSHELL_LOGGING_LEVEL=DEBUG`.

In the next section we'll see about task aggregation (i.e., "bundling").
There are a lot of tunable parameters to govern the cadence of the workflow
and when/how sychronization happens. At this scale, for such brief tasks
we will benefit greatly from defining bundles with `-b`/`--bundlesize`.
We'll coordinate this with the number of executor threads per node.

Contents of `job.sh`:

```sh
#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -N8 -c192 --exclusive -t 1-00:00:00

module load hypershell

export HYPERSHELL_SITE=$(pwd) HYPERSHELL_LOGGING_LEVEL=DEBUG
hsx task.in -N192 -b192 --launcher=srun -f task.failed \
    --no-db --no-confirm 1>task.out 2>/task.log
```

Submit the job using the `sbatch` command and wait for it to complete.

```sh
sbatch job.sh
Submitted batch job 1505938
```

We absolutely could `--capture` the output. But for this example we would
be at the mercy of the filesystem to create all those files and we cannot
commit them to the repository here anyway.

The big idea in this section is to understand that the HyperShell cluster
program is hosting the server thread in-process but with `--launcher` is
now spawning the client instances as extern processes (in this case launching
them up across an distributed allocation with `srun`).

The `-N` option to HyperShell is the number of parallel task executor threads
*per client*. So 192 x 8 = 1,536 workers in this pipeline. Later we'll explore
other layouts with more than one client per node.

The server is packaging bundles of tasks and shipping them off to clients that
are scheduling them locally before shipping bundles of completed tasks back.
One of the main limiting factors in the scalability of *GNU Parallel* is that
it doesn't do this 2-tiered aggregation for synchronization.

We've run this workflow on our Gautschi supercomputer at Purdue's RCAC,
so the hostnames and logging message reflect that, your output would be somewhat
different after adapting the job script to your own cluster.

Here is a tally of task counts executed on which nodes:

```sh
cat task.out | cut -d' ' -f1 | sort | uniq -c | sort -r
```

Output:

```
  13248 a333.gautschi.rcac.purdue.edu:
  13248 a180.gautschi.rcac.purdue.edu:
  12864 a202.gautschi.rcac.purdue.edu:
  12640 a270.gautschi.rcac.purdue.edu:
  12480 a295.gautschi.rcac.purdue.edu:
  11904 a332.gautschi.rcac.purdue.edu:
  11904 a211.gautschi.rcac.purdue.edu:
  11712 a272.gautschi.rcac.purdue.edu:
```
