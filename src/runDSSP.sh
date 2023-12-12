#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --job-name=dssp
#SBATCH --partition=highmem
#SBATCH -n 2
#SBATCH --mem=4G

exe=path/to/rosetta/main/source/bin/rosetta_scripts.linuxgccrelease
database=path/to/rosetta/main/database/;

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

${exe} -parser:protocol ${root_dir}/dssp.xml -in:file:s ${project_dir}/1rfn_relaxed.pdb @${root_dir}/dssp.flag -restore_talaris_behavior -overwrite > ${project_dir}/dssp.log
