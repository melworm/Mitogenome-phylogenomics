#!/bin/bash

# Iterate over each Multiple sequences fasta file to be aligned via MAFFT
for file in *.fasta; do
    # Define output file name
    output_file="${file%.fasta}_aligned.fasta"
    
    # Execute MAFFT for alignment
    mafft --auto "$file" > "$output_file"
    
    # Print message indicating completion
    echo "Alignment of $file completed. Output saved to $output_file"
done
