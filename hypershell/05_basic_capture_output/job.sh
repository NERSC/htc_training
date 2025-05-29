#!/bin/bash
#SBATCH -A mylab -p cpu -q normal
#SBATCH -c42 -t 1-00:00:00

module load hypershell

export HYPERSHELL_SITE=$(pwd)
hsx task.in -N42 -f task.failed --no-db --no-confirm --capture

