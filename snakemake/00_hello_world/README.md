
# Snakemake Hello World

## Installation

    (nersc-python) elvis@perlmutter:login14:~> conda create --channel conda-forge --channel bioconda --name snakemake_env snakemake
    Retrieving notices: ...working... done
    Channels:
     - conda-forge
     - bioconda
     - defaults
    Platform: linux-64
    Collecting package metadata (repodata.json): done
    Solving environment: done

    SNIP

      zipp               conda-forge/noarch::zipp-3.22.0-pyhd8ed1ab_0 
      zstandard          conda-forge/linux-64::zstandard-0.23.0-py312h66e93f0_2 


    Proceed ([y]/n)? y


    Downloading and Extracting Packages:
                                                                                                                                                                              
    Preparing transaction: done                                                                                                                                                   
    Verifying transaction: done                                                                                                                                                   
    Executing transaction: done                                                                                                                                                   
    (nersc-python) elvis@perlmutter:login14:~> conda activate snakemake_env
    (snakemake_env) elvis@perlmutter:login14:~>                                                                                                                                  
## Running the Example

    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/00_hello_world> ls
    README.md  Snakefile
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/00_hello_world> snakemake --cores 1
    Assuming unrestricted shared filesystem usage.
    host: login10
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Provided cores: 1 (use --cores to define parallelism)
    Rules claiming more threads will be scaled down.
    Job stats:
    job            count
    -----------  -------
    all                1
    hello_world        1
    total              2

    Select jobs to execute...
    Execute 1 jobs...

    [Fri May 30 03:30:27 2025]
    localrule hello_world:
        output: hello_world.txt
        jobid: 1
        reason: Missing output files: hello_world.txt
        resources: tmpdir=/tmp

    [Fri May 30 03:30:27 2025]
    Finished jobid: 1 (Rule: hello_world)
    1 of 2 steps (50%) done
    Select jobs to execute...
    Execute 1 jobs...

    [Fri May 30 03:30:27 2025]
    localrule all:
        input: hello_world.txt
        jobid: 0
        reason: Input files updated by another job: hello_world.txt
        resources: tmpdir=/tmp

    [Fri May 30 03:30:27 2025]
    Finished jobid: 0 (Rule: all)
    2 of 2 steps (100%) done
    Complete log(s): /global/u1/w/elvis/tutorial/htc_training/snakemake/00_hello_world/.snakemake/log/2025-05-30T033027.305822.snakemake.log
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/00_hello_world> cat hello_world.txt
    Hello World!
 
