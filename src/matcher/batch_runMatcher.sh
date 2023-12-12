#!/bin/bash

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

cd ${project_dir}/

mkdir -p matcher_output

for positionfile in POSITIONFILE_*;
do
sbatch ${root_dir}/runMatcher.sh ${positionfile}
done
