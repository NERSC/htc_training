
# Snakemake Wildcards

## Example Snakefile

    from pathlib import Path
    name_list = Path("data").iterdir()
    name_list = [file.with_suffix("").name for file in name_list]

    rule all:
        input: expand("output/cool_{name}.txt", name=name_list)

    rule make_cool:
        input: "data/{name}.txt"
        output: "output/cool_{name}.txt"
        shell: "echo xXxXx $(cat data/{wildcards.name}.txt) xXxXx > output/cool_{wildcards.name}.txt"

The first three lines use python to build a list of base filenames from the
data directory. This list is used to create an expanded wildcard input, which
asks for the modified content version of each of those files. The wildcard name
is used in the make_cool rule and its shell script to act on each of the file
names.

## Running the Example

Note that the --quiet flag has been added to shorten the output.

    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/02_wildcards> cat data/*
    "Alice","9","Apple"
    "Bob","18","Cherry"
    "Bort","1","Pipevine"
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/02_wildcards> ls data/
    alice.txt  bob.txt  bort.txt
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/02_wildcards> snakemake --cores 1 --quiet
    Assuming unrestricted shared filesystem usage.
    host: login10
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Select jobs to execute...
    Execute 1 jobs...
    Select jobs to execute...
    Execute 1 jobs...
    Select jobs to execute...
    Execute 1 jobs...
    Select jobs to execute...
    Execute 1 jobs...
    Complete log(s): /global/u1/w/elvis/tutorial/htc_training/snakemake/02_wildcards/.snakemake/log/2025-05-30T053200.540674.snakemake.log
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/02_wildcards> ls output/
    cool_alice.txt  cool_bob.txt  cool_bort.txt
    (snakemake_env) elvis@perlmutter:login10:~/tutorial/htc_training/snakemake/02_wildcards> cat output/*
    xXxXx "Alice","9","Apple" xXxXx
    xXxXx "Bob","18","Cherry" xXxXx
    xXxXx "Bort","1","Pipevine" xXxXx

