#!/bin/bash

parallel --colsep="," echo {1} {3} :::: $1
