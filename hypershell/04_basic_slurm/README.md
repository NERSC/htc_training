Basic (job script)
==================


This is not a Slurm training - but it is the most popular scheduler.
We will include job parameters in future sections to illustrate the interactions
between the job allocation/topology and the HyperShell cluster.

This section is identical to the previous except that we've wrapped the invocation
in a job script submitted to the Slurm scheduler.

Contents of `job.sh`:

```sh
#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -c42 -t 1-00:00:00

module load hypershell

hsx task.in -N42 -f task.failed --no-db --no-confirm
```

You'll need to modify this script to match the cluster and/or scheduler at your site.
Here we have asked for a cpu-only job with 42 cores. We are aligning the number of
HyperShell task executors with the number of cores in our allocation; i.e., these
are single-core tasks.

Submit the job using the `sbatch` command and wait for it to complete.
You can check on the job using `squeue --me`.

```sh
sbatch job.sh
Submitted batch job 1505926
```

We haven't captured the output of our tasks so they just live in the job output
file, `slurm-1505929.out`.

