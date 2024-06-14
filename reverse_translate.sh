#!/bin/bash

# Define the directory containing aligned amino acid files
aa_aligned_dir="/Directory/with/aligned/aa/files/"

# Define the directory containing original nucleotide files (pre_translation)
nt_dir="/Directory/with/original/nucleotide/sequences/"

# Define the directory to save the reverse-translated nucleotide files
output_dir="/Directory/for/PAL2NAL/reults/"

# Iterate over each aligned amino acid file
for aa_file in "${aa_aligned_dir}"*_aa_aligned.fasta; do
    # Extract the protein name from the file name
    protein_name=$(basename "${aa_file%_aa_aligned.fasta}")
    
    # Construct the corresponding nucleotide file name
    nt_file="${nt_dir}${protein_name}.fasta"
    
    # Construct the output file name
    output_file="${output_dir}${protein_name}_nt_pal2nal.fasta"
    
    # Run PAL2NAL
    perl pal2nal.pl "${aa_file}" "${nt_file}" -codontable 5 -output fasta > "${output_file}"
    
    echo "Processed ${protein_name}. Output saved to ${output_file}"
done

