Basic (extreme scale)
=====================

> [!WARNING]
> This section is included for illustrative purposes.
> You likely don't have access to hundreds or thousands of nodes.
> Just notice the use of `-w` and `--delay-start`.

It's unlikely this section will be possible to run for most users.
The goal with this is to illustrate some of the remaining configurable
pieces to operating a cluster.

Run the `make_tasks.sh` script to generate the input file.
This will include a similar set of tasks and only one that will "fail".

```sh
./make_tasks.sh > task.in
```

You can use `wc -l task.in` to confirm (as well as `head task.in`).
And confirm the one pesky "fail" with `grep false task.in`.

> [!NOTE]
> There should be 100M tasks with 10s sleeps (~270k SUs).
> HyperShell's peak throughput of task metadata on the server side
> is roughly 8-10k without a database and ~5k with a database.
> This is only a bottleneck when tasks are short enough at specific scales.

Contents of `job.sh`:

```sh
#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -N1000 -c192 --exclusive -t 1-00:00:00

module load hypershell

export HYPERSHELL_SITE=$(pwd) HYPERSHELL_LOGGING_LEVEL=DEBUG
hsx task.in -N192 -b192 -w60 --launcher=srun -f task.failed \
    --no-db --no-confirm --delay-start=-60 1>task.out 2>/task.log
```

Submit the job using the `sbatch` command and wait for it to complete.

```sh
sbatch job.sh
Submitted batch job 1506941
```

The use of `--delay-start` with the negative number means the clients
will impose a delay of some random interval up to 60 seconds before connecting
to the server. This will stagger the launch and spread out the processing
of task metadata.

We can impose a minimumm holding period prior to clients returning tasks bundles
using `-w` / `--bundlewait` to avoid returning underfilled bundles. The default
value for this is 5 seconds and in most cases doesn't matter much.
At this scale however we want to ensure the coherence between server and client.
