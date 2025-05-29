Basic (templates)
=================

Apply rich template pattern syntax for quickly mapping inputs to commands.
Inspired by *GNU Parallel*, see [documentation](https://hypershell.readthedocs.io/templates.html) for reference.

In this example we have a collection of input files under the `in/` folder.
These data files are a metaphorical 'needle in a hay stack'.
We'll use the Unix `grep` command to filter for our "NEEDLE" out of the
10 thousand lines of "HAY".

```sh
find in/ -type f | hsx -N2 -t 'grep NEEDLE {} > out/{/-}.out' --no-db --no-confirm
```

Here we are capturing the task output with a shell re-direct in the task itself.
The input lines are file paths and are substituted verbatim with the `{}`.
Among other rich syntax (slicing, shell commands, lambdas, ...) we have a collection
of special file path manipulations.

The `{/-}` substitution takes the base name of the input file argument without the
file extension. This sort of template pattern is very handy for large collections of
command sets that are all mapping inputs to outputs, like in model training, data
processing and analysis, etc.

There is no output generated on the console this time.
See the `out/` files for results of this example.

```sh
head out/*
```

```
==> out/01.out <==
00014: NEEDLE

==> out/02.out <==
00104: NEEDLE

==> out/03.out <==
01436: NEEDLE

==> out/04.out <==
09873: NEEDLE

==> out/05.out <==
04325: NEEDLE

==> out/06.out <==
07653: NEEDLE

==> out/07.out <==
02095: NEEDLE

==> out/08.out <==
06323: NEEDLE

==> out/09.out <==
10000: NEEDLE

==> out/10.out <==
00978: NEEDLE

==> out/11.out <==
00873: NEEDLE

==> out/12.out <==
03330: NEEDLE
```
