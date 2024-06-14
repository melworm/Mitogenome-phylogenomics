# Script to translate PCGS into amino acids
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Data import CodonTable
import os

# Get the genetic code table number 5
codon_table_5 = CodonTable.unambiguous_dna_by_id[5]

# List of input FASTA files
input_files = [
    "COX1.fasta", "ND1.fasta", "ND2.fasta", "COX3.fasta",
    "ND6.fasta", "ND4L.fasta", "COX2.fasta", "ND3.fasta",
    "CYTB.fasta", "ND4.fasta", "ATP6.fasta", "ND5.fasta"
]

# Process each input file
for input_file in input_files:
    output_file = os.path.splitext(input_file)[0] + "_aa.fasta"
    with open(output_file, 'w') as aa_fa:
        try:
            for dna_record in SeqIO.parse(input_file, 'fasta'):
                # Use forward DNA sequence only
                dna_seq = dna_record.seq

                # Generate all translation frames using genetic code table 5
                aa_seqs = (dna_seq[i:].translate(table=codon_table_5, to_stop=True) for i in range(3))

                # Select the longest one without stop codons
                try:
                    max_aa = max((seq for seq in aa_seqs if "*" not in seq), key=len)
                    # Use the original header from the input DNA sequence
                    aa_record = SeqRecord(max_aa, id=dna_record.id, description=dna_record.description)
                    SeqIO.write(aa_record, aa_fa, 'fasta')
                    print(f"Processed {input_file}, translated sequences saved to {output_file}")
                except ValueError as e:
                    print(f"Error translating {dna_record.id} in {input_file}: {e}")
        except Exception as e:
            print(f"Error processing {input_file}: {e}")


