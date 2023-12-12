#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --job-name=match
#SBATCH --partition=highmem
#SBATCH -n 16
#SBATCH --mem=32G

exe=path/to/rosetta/main/source/bin/match.linuxgccrelease
database=path/to/rosetta/main/database/;
POSITIONFILE=$1

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

cd ${project_dir}

${exe} -in:file:s 1rfn_relaxed.pdb -match:lig_name NAG -match:geometric_constraint_file CSTFILE.cst -extra_res_fa NAG.fa.params -match:scaffold_active_site_residues ${POSITIONFILE}

mv UM_*.pdb ./matcher_output/
