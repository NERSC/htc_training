
# Example Running GNU Parallel in a single node Perlmutter job

This example uses a given input.txt file containing tasks, and executes them
inside a Slurm job. A number of commands and arguments are specific to Slurm
and the NERSC Perlmutter system, so adjust accordingly when using on a
different system.

input.txt was created with this command: 

    seq 1 12 > input.txt

Run the example for yourself with this command:

    sbatch single_node_many_task_with_parallel.sh

Note you may need to add or modify slurm arguments to meet the policy
requirements of your cluster. On Perlmutter an additional -A flag with your
project name is needed (though if you set the SBATCH_ACCOUNT environment
variable then an -A argument is not needed).


## The --jobs Flag

This example includes a --jobs 6 flag. This instructs GNU parallel to not run
more than 6 jobs at the same time; the 7th job will wait until the first has
finished. Without this flag GNU Parallel will continue launching tasks until
it reaches the number of cores available on the processer.

Some possible reasons to use the --job flag are: 

- Your tasks use more memory than the memory per core available on the node.
  The --jobs flag can be used to prevent an out of memory error or disk
  swapping.
- Tasks are very I/O intensive. If a large number of tasks saturate the
  filesystem, performance can suffer. Reducing the number of concurrent jobs
  can lead to better throughput.
- Tasks use more than one thread, so a known number of tasks which is fewer
  than the number of cores would yield the best performance.

## Demonstration of usage

    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/04_single_node_many_task> sbatch single_node_many_task_with_parallel.sh -A nstaff
    Submitted batch job 39097953
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/04_single_node_many_task> sqs
    JOBID            ST USER      NAME          NODES TIME_LIMIT       TIME  SUBMIT_TIME          QOS             START_TIME           FEATURES       NODELIST(REASON
    39097953         PD elvis    single_node_  1           2:00       0:00  2025-05-28T14:15:03  debug           N/A                  cpu            (Priority)     
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/04_single_node_many_task> sqs
    JOBID            ST USER      NAME          NODES TIME_LIMIT       TIME  SUBMIT_TIME          QOS             START_TIME           FEATURES       NODELIST(REASON
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/04_single_node_many_task> cat slurm-39097953.out 
    This is the payload script. argument_1 is the argument passed to it.
    This is the payload script. argument_2 is the argument passed to it.
    This is the payload script. argument_3 is the argument passed to it.
    This is the payload script. argument_4 is the argument passed to it.
    This is the payload script. argument_5 is the argument passed to it.
    This is the payload script. argument_6 is the argument passed to it.
    This is the payload script. argument_7 is the argument passed to it.
    This is the payload script. argument_8 is the argument passed to it.
    This is the payload script. argument_9 is the argument passed to it.
    This is the payload script. argument_10 is the argument passed to it.
    This is the payload script. argument_11 is the argument passed to it.
    This is the payload script. argument_12 is the argument passed to it.

## Changing the Example to Use for Yourself

Running your own application requires modifying
single_node_many_task_with_parallel.sh by replacing payload.sh with your own
script or executable and changing the task input brackets to match the
arguments your application expects.
