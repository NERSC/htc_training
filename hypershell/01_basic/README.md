Basic (parallel execution)
==========================

The `-N` flag defines the number of parallel works (task executors).
Later, we’ll see this is the number of workers *per-client*.

```sh
seq 12 | hsx -N4 -t 'sleep 1 && echo {}' --no-db --no-confirm
```

This example is similar to the previous one.
The expected output is stored in `output.txt`.
While this runs, notice how the output comes in bursts of 4.

Later on we'll make use of a database for persistence and many other
benefits. During execution in a distributed cluster environment,
the server checks on clients using a heartbeat mechanism and registers
the receipt of tasks on a dedicated *confirm* channel to more gracefully
reschedule tasks when clients fail or go missing (i.e., "task stealing").

When not using a database (`--no-db`) it makes sense to disable this
un-actionable overhead (`--no-confirm`).


