#!/bin/bash

parallel echo "stdin redirect argument {}" < tasks.txt

parallel echo "four colon argument {}" :::: tasks.txt

#demonstrate the prodct of two input lists
parallel echo "list product argument {}" :::: tasks.txt :::: tasks.txt

#Combine a command evaluation, three colon operator, file list input, and plus operator
#with catenation
parallel echo "mixing types and + argument {}" ::: $(seq 1 100) ::::+ tasks.txt
