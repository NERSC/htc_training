
# Example Running GNU Parallel in a Slurm Job with Multiple Nodes

This example uses a given input.txt file containing tasks, and executes them
using multiple nodes on a cluster. It is written expecting Slurm as the batch
scheduler and Perlmutter as the cluster; if you are working with different
resources modify the scripts accordingly.

input.txt was created with this command:

    seq 1 12 > input.txt

Run the example for yourself with this command:

    sbatch many_node_many_task.sh input.txt

On the NERSC Perlmutter system an either an additional -A flag with your
project name is needed, or you can set the SBATCH_ACCOUNT environment variable.

## Notes on srun

The presence of srun in many_node_many_task.sh is load-bearing in this example.
In the default HPC use case, a single MPI application is launching processes
across every node in the job; it is the role of srun to create the many
instances of the application, distribute them to the correct nodes, and provide
the MPI communicator which links them together.

In this demonstration, we are using srun to create multiple GNU parallel
processes and distribute exactly one to each node. Beyond that, we don't need,
and simply ignore, the MPI capabilities of srun. Only one level of srun can
exist in a Slurm workflow, so if the payload application requires MPI then a
different arrangement of distributing work to different nodes must be used.

## Modifying for Yourself

Replace the example script with your own application by modifying driver.sh.
Change the parallel command at the bottom to remove payload.sh and insert your
task application and its arguments. After doing this, payload.sh is no longer
needed. 

Remember that there will be one GNU Parallel instance running for each node in
the job, so if you choose to use the --jobs flag, consider that this is
limiting the number of tasks that run in parallel on *one* node.

Choosing the number of nodes in your job can be done in two ways: 

Modify this line in many_node_many_task.sh to change the number of nodes your
job will request:

    #SBATCH --nodes=2

Alternatively, your sbatch command could be given a --nodes=X flag.

    sbatch --nodes=3 many_node_many_task.sh input.txt -A ntrain7

## Demonstration

    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/05_many_node_many_task> sbatch -A nstaff many_node_many_task.sh input.txt 
    Submitted batch job 39098734
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/05_many_node_many_task> sqs
    JOBID            ST USER      NAME          NODES TIME_LIMIT       TIME  SUBMIT_TIME          QOS             START_TIME           FEATURES       NODELIST(REASON
    39098734         PD elvis    many_node_ma  2          10:00       0:00  2025-05-28T14:46:41  debug           N/A                  cpu            (Priority)     
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/05_many_node_many_task> sqs
    JOBID            ST USER      NAME          NODES TIME_LIMIT       TIME  SUBMIT_TIME          QOS             START_TIME           FEATURES       NODELIST(REASON
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/05_many_node_many_task> cat slurm-39098734.out 
    This is the payload script. argument_2 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_4 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_6 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_8 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_10 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_12 is the argument passed to it. Ran on machine nid006934.
    This is the payload script. argument_1 is the argument passed to it. Ran on machine nid006941.
    This is the payload script. argument_3 is the argument passed to it. Ran on machine nid006941.
    This is the payload script. argument_5 is the argument passed to it. Ran on machine nid006941.
    This is the payload script. argument_7 is the argument passed to it. Ran on machine nid006941.
    This is the payload script. argument_9 is the argument passed to it. Ran on machine nid006941.
    This is the payload script. argument_11 is the argument passed to it. Ran on machine nid006941.
