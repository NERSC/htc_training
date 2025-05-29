#!/bin/bash
#SBATCH --qos=debug
#SBATCH --nodes=2
#SBATCH --constraint=cpu
#SBATCH -t 00:02:00

./driver.sh 
