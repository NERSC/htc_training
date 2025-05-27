
# Using Files to Pass Lists of Tasks to GNU Parallel

## Running the Example 

The example script can be run in this directory with the command:

    ./tasks_from_files.sh

The expected output is available in the file expected_output.txt

### Four Colon Notation
 
A four colons (::::) operator on a GNU parallel command accepts a file path,
and the content of that file is treated as a list of tasks.

### File to Stdin

A file can be redirected to the stdin of GNU Parallel using a "<"

## More Advanced Task Input

Combinations of colon input lists can include four colon file lists, as well.
The same behavior regarding combinations of inputs to form tasks and the plus
sign to create dot products also apply.
