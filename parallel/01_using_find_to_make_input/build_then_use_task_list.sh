#!/bin/bash

find $PWD -type f | grep txt | sort > tasks

parallel "cat {} > {//}/{/.}.output" :::: tasks
