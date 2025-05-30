#!/bin/bash

parallel "snakemake --quiet --cores 1 output/cool_{/.}.txt" ::: $(ls data | grep txt)
