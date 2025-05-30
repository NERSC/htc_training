
# Snakemake Basic Dependency

## Example Snakefile

    rule all:
        input: "cool_hello_world.txt"

    rule make_cool:
        input: "hello_world.txt"
        output: "cool_hello_world.txt"
        shell: "echo xXxXx $(cat hello_world.txt) xXxXx > cool_hello_world.txt"

    rule hello_world:
        output: "hello_world.txt"
        shell: "echo Hello World! > hello_world.txt"

Dependencies between tasks are encoded by chaining the input and output file
names of multiple rules. The actual processing which uses the input to produce
the output is described in the nearby shell string.

## Running the Example

Note that the --quiet flag has been added to shorten the output.

    (snakemake_env) warndt@perlmutter:login35:~/tutorial/htc_training/snakemake/01_task_dependency> snakemake --cores 1 --quiet
    Assuming unrestricted shared filesystem usage.
    host: login35
    Building DAG of jobs...
    Using shell: /usr/bin/bash
    Select jobs to execute...
    Execute 1 jobs...
    Select jobs to execute...
    Execute 1 jobs...
    Select jobs to execute...
    Execute 1 jobs...
    Complete log(s): /global/u1/w/warndt/tutorial/htc_training/snakemake/01_task_dependency/.snakemake/log/2025-05-30T041718.962967.snakemake.log
    (snakemake_env) warndt@perlmutter:login35:~/tutorial/htc_training/snakemake/01_task_dependency> ls
    cool_hello_world.txt  expected_output.txt  hello_world.txt  README.md  Snakefile
    (snakemake_env) warndt@perlmutter:login35:~/tutorial/htc_training/snakemake/01_task_dependency> cat cool_hello_world.txt
    xXxXx Hello World! xXxXx

