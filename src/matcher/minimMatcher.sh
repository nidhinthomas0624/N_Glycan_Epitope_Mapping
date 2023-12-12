#!/bin/bash
#SBATCH --time=48:00:00
#SBATCH --job-name=match
#SBATCH --partition=highmem
#SBATCH -n 2
#SBATCH --mem=4G

exe=path/to/rosetta/main/source/bin/rosetta_scripts.linuxgccrelease;
database=path/to/rosetta/main/database/;

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

${exe} -database ${database} -parser:protocol ${root_dir}/minimMatcher.xml  -extra_res_fa ${project_dir}/NAG.fa.params @${project_dir}/restraint.flag -parser_read_cloud_pdb 1 -restore_talaris_behavior -in:file:l $1
