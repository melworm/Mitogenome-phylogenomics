#!/bin/bash

# Loop through directories
for dir in Directory/containing/fiels; do
    # Check if the directory contains both .bed and .fasta files(the .fasta must be the mitogenome assembly)
    bed_files=( "${dir}"*result.bed )
    fasta_files=( "${dir}"*.fasta )
    if [[ ${#bed_files[@]} -eq 1 && ${#fasta_files[@]} -eq 1 ]]; then
        # Extract filenames
        input_bed="${bed_files[0]}"
        input_fasta="${fasta_files[0]}"
        # Extract sequences using getfasta
        bedtools getfasta -fi "$input_fasta" -bed "$input_bed" -fo "${dir}result.fasta" -name
        echo "Processed files in directory $dir"
    else
        echo "Skipping $dir: Either result.bed or .fasta file is missing."
    fi
done

