#!/bin/bash

# Iterate over the files in the specified pattern to extract gene information to create a bed file
for file in your/directory/*.gff3; do
  awk -F'\t' 'BEGIN {OFS="\t"} !/^#/ && NF > 0 && $3 == "gene" && $2 != "source" {split($9, a, /[=;]/); print $1, $4-1, $5, a[2]}' "$file" >> "${file}_result.bed"
done
