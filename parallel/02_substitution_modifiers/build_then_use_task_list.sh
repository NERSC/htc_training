#!/bin/bash

path=$PWD
if test -n "$1"
then
    path=$1
fi

find $path -type f | grep txt | sort > tasks

parallel "cat {} > {//}/{/.}.output" :::: tasks
