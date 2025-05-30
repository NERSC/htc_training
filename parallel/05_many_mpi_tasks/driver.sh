#!/bin/bash

parallel --delay 3 --jobs 4 srun -c 64 -n 2 --distribution=block,pack --network=no_vni ./payload.sh {} ::: $(seq 1 4)
