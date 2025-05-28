
# GNU Parallel stand-alone commands

## Running the Example 

The example script can be run in this directory with the command:

    ./example_one_liners.sh

The expected output is available in the file expected_output.txt

### Three Colon Notation
 
A GNU Parallel command including three colons (:::) accepts a list of tasks
separated by spaces. This works well when you won't need to repeat the tasks,
and the list of tasks is small and simple enough that typing it on the command
line would be faster than encoding it another way. 

### Pipe

Command line pipes can be used to combine GNU Parallel with a bash command
which generates the list of tasks. This is a similar capability to the three
colon notation, but with the added benefit that the generator command (think
seq, ls, or find) can produce more tasks than would be reasonable to type
manually.

## More Advanced Task Input

### Lists of File Paths Using Wildcards

A three colon operator can accept linux filename wildcard operators such as \*,
?, and \[...\]. When doing so, the resulting task list will include any
paths in the current working directory which fit the wildcard pattern.

    elvis@perlmutter:login31:~/tutorial/htc_training/parallel/02_substitution_modifiers> parallel echo {} ::: data/*.txt
    data/task_1.txt
    data/task_two.txt
    data/tsk-3.txt

### Multiple Input Lists

In general, the reason to choose colon inputs instead of the others is
additional flexibility. Multiple input lists can be passed to a single GNU
Parallel command, and the result is the product of each list. This can remove
the need for for loops somewhere else in the workflow where all combinations of
items from two lists need to be iterated through. 

parallel echo {} ::: 1 2 ::: a b
1 a
1 b
2 a
2 b

Position integers can be added to substitution brackets to insert individual
list members:

parallel echo {2} {1} ::: 1 2 ::: a b
a 1
b 1
a 2
b 2

Additionally, a plus sign (+) can be appended to the colon notation to change
the combination method to a dot product. If the lists are of different sizes,
the outcome truncates to the size of the smaller one.

parallel echo {} ::: 1 2 :::+ a b
1 a
2 b

### Lists Build by Command Substitution

Three colon task lists can be given a command substitution which evaluates to a
large number of items. This can also be combined to create the product of
multiple lists.

parallel echo {} ::: $(seq 1 2) ::: $(seq 3 4)
1 3
1 4
2 3
2 4
 
