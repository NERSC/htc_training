
# Passing a List of Tasks to GNU Parallel

## Running the Example 

The example script can be run in this directory with the command:

    ./providing_tasks.sh

The expected output is available in the file expected_output.txt

### Three Colon Notation
 
A GNU Parallel command with three colons (:::) accepts a list of tasks separated by spaces. This works well when you won't need to repeat the tasks, and the list of tasks is small and simple enough that typing it on the command line would be faster than encoding it another way. 

### Pipe

Command line pipes can be used to combine GNU Parallel with a bash command which generates the list of tasks. This is a similar capability to the three colon notation, but with the added benefit that the generator command (think seq or find) can produce more tasks than would be reasonable to type manually.

### File to Stdin

A file can be redirected to the stdin of GNU Parallel using a "<"

### Four Colon Notation

A GNU Parallel command with four colons (::::) accepts a file path, and the content of that file is treated as a list of tasks.

## More Advanced Task Input

In general, the reason to choose colon inputs instead of the others is additional flexibility. Multiple three or four colon input lists can be passed to a single GNU Parallel command, and the result is the product of each list. This can remove the need for for loops somewhere else in the workflow where all combinations of items from two lists need to be iterated through. 

Additionally, a plus sign (+) can be appended to the colon notation to change the combination method to a dot product. Contrast these two examples:

> ::: 1 2 ::: a b
>
> outcome:
>
> 1 a
>
> 1 b
>
> 2 a
>
> 2 b

> :::+ 1 2 ::: a b
>
> outcome:
>
> 1 a
>
> 2 b

