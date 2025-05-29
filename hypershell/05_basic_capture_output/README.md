Basic (capturing output)
========================

We haven't yet learned anything about configuration.
Most things in the HyperShell system are configurable within one or more files:

- `/etc/hypershell.toml` (system)
- `~/.hypershell/config.toml` (user)
- `.hypershell/config.toml` (local)

All of these can also be defined as environment variables.
Some special things are *only* definable as environment variables.

For capturing output within a job context we should define `HYPERSHELL_SITE`.
This *site* is the location on the filesystem used for many things but importantly
it is used for spooling the *stdout* and *stderr* of tasks.

Use the `--capture` flag to capture `.out` and `.err` files for each task.
The *site* will include at a minimum a `lib/` and `/log` directory.
The captured files will be stored under `lib/task` and isolated by their UUID.

Contents of `job.sh`:

```sh
#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -c42 -t 1-00:00:00

module load hypershell

export HYPERSHELL_SITE=$(pwd)
hsx task.in -N42 -f task.failed --no-db --no-confirm --capture 2>/task.log
```

Submit the job using the `sbatch` command and wait for it to complete.

```sh
sbatch job.sh
Submitted batch job 1505938
```

Now the individual task output has been captured in separate files.
We've also redirected the HyperShell logging output to a file.
Right now we're only seeing `WARNING` messages.
We should enable more copious output which would include details about
the task execution. We could check the UUIDs here to see where our output
went to, but in a later section we'll enable the database to track all of
these things for us and we won't need to worry so much about *where* some
task output is because we can recover it programmatically (and even over SFTP).

For right now we can just confirm the outputs manually using shell commands.

```sh
head lib/task/*.out
```

Output:

```
==> lib/task/1f1e8d05-afb2-45ba-8b11-0ffac23947a6.out <==
10

==> lib/task/344bdce4-806c-4618-b85d-b3a4cdd9b394.out <==
11

==> lib/task/375cd8c7-5945-4417-ab8d-0d718becf75a.out <==
12

==> lib/task/432c41ac-7c12-414a-9f11-90d964a58ad0.out <==
1

==> lib/task/62ae32dc-55c9-4f41-b187-ba445f6e7728.out <==
3

==> lib/task/68b884e5-7167-43dd-98c0-4a13113b6ea0.out <==
6

==> lib/task/770a153a-2c4d-4c25-ac18-a2bdd25731e8.out <==
4

==> lib/task/7f69daab-d715-4da7-b75c-3b4da7258d3d.out <==
9

==> lib/task/808620bc-8c97-462f-9421-d6bbf891f29b.out <==
5

==> lib/task/99a285a8-5451-4caa-afdb-7cb440568f1a.out <==
2

==> lib/task/9d907ef6-f1d6-40e8-86c4-cfd87e8e7a65.out <==
7

==> lib/task/dbb68894-254d-4f9d-93d8-c3dff9da7f4e.out <==
8
```
