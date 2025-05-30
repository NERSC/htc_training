
# GNU Parallel Running Snakemake

The goal with this example is to demonstrate benefits using combinations of
workflow tools. The stub workflow intends to take all files in the data
directory, decorate them, and write the result with a new filename to the
output directory.

The method needed to create a Snakemake wildcard which includes all files in
a directory is a bit convoluted, so we'll hand that responsibility to parallel.
Snakemake is still managing dependencies, running the shell
command to apply the modification, and logging. The task of isolating the
potential input files, preparing the base filename, and running a snakemake
pipeline for each is given to parallel.

## Example Snakefile

    rule make_cool:
        input: "data/{name}.txt"
        output: "output/cool_{name}.txt"
        shell: "echo xXxXx $(cat data/{wildcards.name}.txt) xXxXx > output/cool_{wildcards.name}.txt"

## Companion driver.sh script

    #!/bin/bash
    parallel "snakemake --quiet --cores 1 output/cool_{/.}.txt" ::: $(ls data)

## Running the Example

    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> ls output/
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> ls data/
    alice.txt  bob.txt  bort.txt
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> cat data/*
    "Alice","9","Apple"
    "Bob","18","Cherry"
    "Bort","1","Pipevine"
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> bash driver.sh
    Assuming unrestricted shared filesystem usage.
    host: login10
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Select jobs to execute...
    Execute 1 jobs...
    Complete log(s): /global/u1/w/elvis/tutorial/htc_training/snakemake/03_parallel_runs_snakemake/.snakemake/log/2025-05-30T055512.215843.snakemake.log
    Assuming unrestricted shared filesystem usage.
    host: login10
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Select jobs to execute...
    Execute 1 jobs...
    Complete log(s): /global/u1/w/elvis/tutorial/htc_training/snakemake/03_parallel_runs_snakemake/.snakemake/log/2025-05-30T055512.216283.snakemake.log
    Assuming unrestricted shared filesystem usage.
    host: login10
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Select jobs to execute...
    Execute 1 jobs...
    Complete log(s): /global/u1/w/elvis/tutorial/htc_training/snakemake/03_parallel_runs_snakemake/.snakemake/log/2025-05-30T055512.231694.snakemake.log
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> ls output/
    cool_alice.txt  cool_bob.txt  cool_bort.txt
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/03_parallel_runs_snakemake> cat output/*
    xXxXx "Alice","9","Apple" xXxXx
    xXxXx "Bob","18","Cherry" xXxXx
    xXxXx "Bort","1","Pipevine" xXxXx

