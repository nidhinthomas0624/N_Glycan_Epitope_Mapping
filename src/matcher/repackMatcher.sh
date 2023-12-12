#!/bin/bash

#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --job-name=match
#SBATCH --partition=highmem
#SBATCH -n 2
#SBATCH --mem=4G

exe=path/to/rosetta/main/source/bin/rosetta_scripts.linuxgccrelease;
database=path/to/rosetta/main/database/;

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

inputFile=$1
list_identifier=${inputFile%.*}

mkdir ${project_dir}/matcher_output/${list_identifier}

echo "starting the repacking"

while read pdbfile; do

    cp ${root_dir}/repackMatcher.xml ./${list_identifier}/
    cp ${project_dir}/NAG.fa.params ./${list_identifier}/
    cp ${root_dir}/restraint.flag ./${list_identifier}/
    cp ${project_dir}/CSTFILE.cst ./${list_identifier}/
    cp ${project_dir}/NAG.pdb ./${list_identifier}/
    mv ${project_dir}/matcher_output/${pdbfile} ./${list_identifier}/
    cp ${root_dir}/generate_resfile_around_residues.py ./${list_identifier}/

    cd ./${list_identifier}/

    residue_number=$(echo "$pdbfile" | cut -d'_' -f3  | sed 's/N//')

    python generate_resfile_around_residues.py -f ${pdbfile} --nglycan 1 --residuenumber ${residue_number}

    ${exe} -database ${database} -parser:protocol repackMatcher.xml  -extra_res_fa NAG.fa.params @restraint.flag -parser_read_cloud_pdb 1 -restore_talaris_behavior -in:file:s ${pdbfile}

    cd ../

done<"${inputFile}"

echo "Repacking completed"
