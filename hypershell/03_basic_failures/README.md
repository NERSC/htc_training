Basic (failed tasks)
====================

Use `-f`/`--failures` to redirect inputs that result in a non-zero exit status.
We’re simulating failures using the Unix `true` and `false` programs.
Later, we’ll see how to use `--max-retries` with the database enabled.

```sh
hsx task.in -N4 --no-db --no-confirm -f task.failed
```

Look at the `task.in` file to see how we're simulating failures.
Notice the `false` on line 7.

Contents of `task.in`:

```sh
sleep 1 && echo 1  && true
sleep 1 && echo 2  && true
sleep 1 && echo 3  && true
sleep 1 && echo 4  && true
sleep 1 && echo 5  && true
sleep 1 && echo 6  && true
sleep 1 && echo 7  && false
sleep 1 && echo 8  && true
sleep 1 && echo 9  && true
sleep 1 && echo 10 && true
sleep 1 && echo 11 && true
sleep 1 && echo 12 && true
```

Output is recorded in `output.txt` and the failed task is captured
in `task.failed`.

This mechanism is inspired by the simple but venerable *ParaFly* workflow tool.
You could easily re-direct this list of failed inputs back into the program
as a crude retry mechanism!

See: [https://parafly.sourceforge.net/](https://parafly.sourceforge.net/)
