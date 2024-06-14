#!/bin/bash

# Define the directory containing the FASTA files for multiple species (each file would contain fasta sequences of all annotated genes in one sample)
multi_species_dir="/Directory/for/Species_hub"

# Define an array of genes to search for
genes=("COX1" "ND1" "ND2" "COX3" "ND6" "ND4L" "COX2" "ND3" "CYTB" "ND4" "ATP6" "ND5" "rrn12" "rrn16")

# Loop through each FASTA file in the directory
for fasta_file in "$multi_species_dir"/*.fasta; do
    # Process each gene in the array
    for gene in "${genes[@]}"; do
        # Create the output filename for the gene-specific FASTA file
        output_file="${gene}.fasta"
        
        # Initialize a flag to indicate whether the gene has been found
        gene_found=false
        
        # Process each line in the FASTA file
        while IFS= read -r line; do
            # Check if the line is a header
            if [[ $line == ">"* ]]; then
                # Extract the gene name from the header
                header_gene=$(echo "$line" | sed -n 's/^>.*_\([^_]*\).*$/\1/p')
                
                # Check if the extracted gene name matches the current gene
                if [[ "$header_gene" == "$gene" ]]; then
                    # Set the flag to indicate that the gene has been found
                    gene_found=true
                    echo "Gene $gene found in header."
                    # Output the header to the gene-specific FASTA file
                    echo "$line" >> "$output_file"
                else
                    # If another gene header is encountered, break out of the loop
                    if $gene_found; then
                        break
                    fi
                fi
            elif $gene_found; then
                # Output the sequence lines to the gene-specific FASTA file
                echo "$line" >> "$output_file"
            fi
        done < "$fasta_file"
    done
done

