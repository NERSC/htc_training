#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -c42 -t 1-00:00:00

module reset
module load hypershell

hsx task.in -N42 -f task.failed --no-db --no-confirm

