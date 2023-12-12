#!/bin/bash

# Set the directory path

root_dir="$(dirname "$(realpath "$0")")"
project_dir="path/to/N_Glycan_Epitope_Mapping/1rfn/"

dir=${project_dir}/matcher_output/

# Use the find command to list all .pdb files in the directory
find $dir -name "*_0001.pdb" > ${dir}/pdb_files_repack.txt

# Print a message to the user
echo "List of .pdb files generated in the file pdb_files_repack.txt"

split -l 50 ${dir}/pdb_files_repack.txt file_ --additional-suffix=.txt && for f in file_*; do mv "$f" "${dir}/pdb_file_repack_split_$((++i)).txt"; done


for file in ${dir}/pdb_file_repack_split_*.txt;
do
	sbatch ${root_dir}/repackMatcher.sh ${file}
done
