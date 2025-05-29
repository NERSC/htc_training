
# Example Using GNU Parallel to Run MPI Applications for Throughput

This example uses GNU parallel to launch multiple application instances which
require MPI. This is useful when the only available versions of your
application use MPI to access multiple cores, instead of supporting a threading
model. If the application scaling achieves optimal throughput at a scale
smaller than the size of an entire node, then it is desirable to pack multiple
application instances onto each one.

The general structure of this example is, inside the Slurm job allocation a
single parallel command is used to accept input tasks and launch the
applications with srun.

## Notes on srun

HPC systems run MPI applications using a launcher command such as mpirun or
srun (on a Slurm system, like Perlmutter). srun commands cannot be nested, so
they must be placed immediately before the application invocation, and other
methods are required to fan out the multiple application calls. Additionally,
srun commands can incur some load at the system level, potentially leading to 
performance degredation for other users if the rate of calling commands is too
high.

## Example Details Specific to Slurm and Perlmutter

A Slurm managed cluster has a single controller in charge of managing the
system. Individual srun commands use some capacity of that controller; if too
many srun commands are called in a period of time the controller can be
overloaded which degrades performance for the entire cluster. The --delay 3
flag has been added to the parallel command to limit the srun rate.

Slurm takes responsibility for managing the allocation of resources on nodes,
including network adapters. The --network=no_vni flag tells srun that it is ok
for applications to share them; otherwise the number of applications on a node
would be limited by the availability of four adapters.

The default Slurm behavior when assigning MPI processes to hardware is to
spread out to all nodes in the job. This default makes sense in the case of a
single application, but when running many in parallel, adds network latency
between processes which could otherwise all run on the same node. The srun
--distribution=block,pack flag changes this behavior to better suit a HTC
workload.

## Modifying for Yourself

Replace the example script with your own application by modifying driver.sh.
Change the parallel command at the bottom to remove payload.sh and insert your
task application and its arguments. After doing this, payload.sh is no longer
needed. 
    
There are a number of changes needed to control the number of nodes to be used,
number of concurrent applications, number of processes per application, and the
number of cores per process. Make sure to pay attention to the math keeping
these in balance; number of nodes \* cores per node = number of applications \*
number of processes per application \* number of cores per procees.
 
- #SBATCH --nodes=X sets the number of nodes
- Cores per node is a property of the hardware, a Perlmutter CPU node has 256
  cores.
- Number of applications is set by either the size of the task list given to
  parallel or the parallel --jobs flag.
- Number of processes per application is set by the srun -n argument.
- Number of cores per process is set by the srun -c argument.

## Demonstration

    elvis@perlmutter:login33:~/tutorial/htc_training/parallel/06_many_mpi_tasks> sbatch many_mpi_tasks.sh -A nstaff
    Submitted batch job 39151728
    elvis@perlmutter:login33:~/tutorial/htc_training/parallel/06_many_mpi_tasks> sqs
    JOBID            ST USER      NAME          NODES TIME_LIMIT       TIME  SUBMIT_TIME          QOS             START_TIME           FEATURES       NODELIST(REASON
    39151728         PD elvis    many_mpi_tas  2           2:00       0:00  2025-05-29T11:06:28  debug           N/A                  cpu            (Priority)     
    elvis@perlmutter:login33:~/tutorial/htc_training/parallel/06_many_mpi_tasks> cat slurm-39151728.out 
    This is payload script of hypothetical MPI application number 1 MPI proc number: 0 Host: nid005126
    This is payload script of hypothetical MPI application number 1 MPI proc number: 1 Host: nid005126
    This is payload script of hypothetical MPI application number 2 MPI proc number: 1 Host: nid005462
    This is payload script of hypothetical MPI application number 2 MPI proc number: 0 Host: nid005462
    This is payload script of hypothetical MPI application number 3 MPI proc number: 0 Host: nid005126
    This is payload script of hypothetical MPI application number 3 MPI proc number: 1 Host: nid005126
    This is payload script of hypothetical MPI application number 4 MPI proc number: 0 Host: nid005462
    This is payload script of hypothetical MPI application number 4 MPI proc number: 1 Host: nid005462
    elvis@perlmutter:login33:~/tutorial/htc_training/parallel/06_many_mpi_tasks> sacct -j 39151728
    JobID           JobName  Partition    Account  AllocCPUS      State ExitCode 
    ------------ ---------- ---------- ---------- ---------- ---------- -------- 
    39151728     many_mpi_+ regular_m+     nstaff        512  COMPLETED      0:0 
    39151728.ba+      batch                nstaff        256  COMPLETED      0:0 
    39151728.ex+     extern                nstaff        512  COMPLETED      0:0 
    39151728.0   payload.sh                nstaff        128  COMPLETED      0:0 
    39151728.1   payload.sh                nstaff        128  COMPLETED      0:0 
    39151728.2   payload.sh                nstaff        128  COMPLETED      0:0 
    39151728.3   payload.sh                nstaff        128  COMPLETED      0:0 
