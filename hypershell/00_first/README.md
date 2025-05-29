Hello World
===========

Let’s run the simplest possible example to get started.
The `hsx` program is short-hand for `hs cluster` and `-t` applies a command template
to incoming arguments – not unlike GNU Parallel.

```sh
seq 4 | hsx -t 'echo {}'
```

The `seq` command is a Unix program that simply writes a sequence of integers
in a range. In this case the numbers 1 - 4 (see `task.in`).

The expected output (assuming you've not configured anything yet) is recorded
in `output.txt`.

Consider using the `--no-db` flag to suppress the warning in this context.
