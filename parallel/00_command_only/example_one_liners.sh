#!/bin/bash

#examples of stand alone command lines using parallel

parallel echo "three colon argument {}" ::: 4 5 6 7 8

#multiple ::: operators can be used, the task list will be 
#the cross product of all of them
parallel echo "cross combinations {}" ::: 1 2 3 ::: a b c

seq 4 8 | parallel echo "seq pipe argument {}"

#ls can be piped directly into parallel, creating
#one task per each file or directory
ls | parallel echo "ls pipe argument {}" 

#same as previous, but using command substitution
parallel echo "ls command substitution argument {}" ::: $(ls)

#find can produce more information than ls 
#(like a full path): find $PWD -type f
#adding a grep can filter out files that shouldn't be tasks
find data -type f | grep txt | parallel cat {}
