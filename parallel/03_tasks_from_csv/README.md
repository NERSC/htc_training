# Using Column Separator flag to Extract Parts of a Task Input Line

The argument given to the --colsep flag specifies the boundary between tokens
of the input line. This example is a .csv file so we have given colsep the ","
character.

After choosing the columnn separator, each token can be referred to in the
command by placing an integer inside the substitution brackets. {1} will be
replaced with the first token, {2} will be replaced with the second token, and
so on.
 
Note that GNU-parallel documentation mentions a --csv flag; this flag uses a
parser from the Perl Text::CSV module, which may not be installed with the
system provided Perl. If you really wanted to use that flag you could install
your own copy of Perl, obtain the Text::CSV module from CPAN, and modify your
path such that parallel finds your Perl copy before the system copy.
 
The NERSC Perlmutter system provides a Perl which doesn not include Text::CSV.

# Example

Run the example script with this command:
    
    ./csv_parse.sh input.csv

A copy of the expected output is located in expected_output.txt

    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/03_tasks_from_csv> cat input.csv 
    "Bob","18","Cherry"
    "Alice","9","Apple"
    "Bort","1","Pipevine"
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/03_tasks_from_csv> cat csv_parse.sh 
    #!/bin/bash
    parallel --colsep="," echo {1} {3} :::: $1
    elvis@perlmutter:login21:~/tutorial/htc_training/parallel/03_tasks_from_csv> ./csv_parse.sh input.csv 
    "Bob" "Cherry"
    "Alice" "Apple"
    "Bort" "Pipevine"
