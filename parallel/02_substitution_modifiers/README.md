# Using Path Substitution Modifiers

This example combines the find command with path substitution modifiers to
assemble tasks from the content of a directory and construct matching output
file names and paths. 

An example data directory starts out with these contents:

    elvis@perlmutter:login08:~/tutorial/htc_training/parallel/02_substitution_modifiers/data> ls -lh
    total 2.0K
    -rw-rw---- 1 elvis elvis 49 May 19 12:10 dont_use.dat
    -rw-rw---- 1 elvis elvis 25 May 16 14:13 task_1.txt
    -rw-rw---- 1 elvis elvis 25 May 16 14:13 task_two.txt
    -rw-rw---- 1 elvis elvis 29 May 16 14:13 tsk-3.txt

The goal is to process each .txt file with a parallel command, and to organize
output files by naming them based on the input filename and in the same
location.

This begins by choosing the directory to search for .txt files. This script
defaults to the current working directory stored in $PWD, but if an argument is
given, then that path will be searched instead.

    path=$PWD
    if test -n "$1"
    then
        path=$1
    fi
 
Next, the find command will recursively report descendent files from the path
it is given.

    find $path -type f | grep txt | sort > tasks

This is piped to a grep command which seeks only file paths containing "txt"
(the extension present on example data files). Be careful that the search
string doesn't include any substrings from the path.

The remaining data files and their full path is sorted and placed in a "tasks"
file in the current working directory.
 
Next the script runs this parallel command:

    parallel "cat {} > {//}/{/.}.output" :::: tasks

Note the command is in quotes; this is needed when the redirect character (>)
is present. The cat command opens the filename and, through its full path,
prints the output to a newly constructed filename and path.

This example introduces more variations of the GNU parallel substitution
brackets: Inserting two slashes {//} modifies a path by removing the filename
and extension, leaving only the directory path. Second, there is a {/.}
substitution which removes the directory path and the extension, leaving only
the filename. 

Using these two substitutions, a "/" character, and an ".output" extension, we
can create a path and name for the output file which will appear in the same
location as the input, have the same name as the input file but with a distinct
".output" extension. Thus, the same script can be reused on similar data
directories anywhere on the filesystem, and the outputs will be placed relative
to their inputs.

See the expected state of the data directory after running
build_then_use_task_list.sh: 

    elvis@perlmutter:login08:~/tutorial/htc_training/parallel/02_substitution_modifiers/data> ls -lh
    total 3.5K
    -rw-rw---- 1 elvis elvis 49 May 19 12:10 dont_use.dat
    -rw-rw---- 1 elvis elvis 25 May 27 16:48 task_1.output
    -rw-rw---- 1 elvis elvis 25 May 16 14:13 task_1.txt
    -rw-rw---- 1 elvis elvis 25 May 27 16:48 task_two.output
    -rw-rw---- 1 elvis elvis 25 May 16 14:13 task_two.txt
    -rw-rw---- 1 elvis elvis 29 May 27 16:48 tsk-3.output
    -rw-rw---- 1 elvis elvis 29 May 16 14:13 tsk-3.txt
    elvis@perlmutter:login08:~/tutorial/htc_training/parallel/02_substitution_modifiers/data> cat *
    This is not a task to run. We want to ignore it.
    Input for task number 1.
    Input for task number 1.
    Input for task number 2.
    Input for task number 2.
    Input for task number three.
    Input for task number three.
