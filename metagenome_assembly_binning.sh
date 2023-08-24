#!/bin/bash

# metagenome_assembly_binning.sh
# Author: Hesham Almessady
# Description: This script performs metagenome assembly of input reads
# 		and genome binning of the assembled contigs.


# Download forward reads and reverse reads files
wget https://sra-pub-src-1.s3.amazonaws.com/SRR25621597/122_1.fastq.gz.1
wget https://sra-pub-src-1.s3.amazonaws.com/SRR25621597/122_2.fastq.gz.1

# Rename files
mv 122_1.fastq.gz.1 122_1.fastq.gz
mv 122_2.fastq.gz.1 122_2.fastq.gz

echo "Download complete"

# Perform Metagenome assembly using MEGAHIT assembler
docker run -v $PWD:/data quay.io/biocontainers/megahit:1.2.9--h2e03b76_1 \
megahit -1 /data/122_1.fastq.gz -2 /data/122_2.fastq.gz -o /data/megahit_output

echo "Metagenome assembly is completed"

# Perform genome binning of the assembled contigs using MetaBAT 
docker run -v $PWD:/data quay.io/biocontainers/metabat2:2.15--h986a166_1 \
metabat -i /data/megahit_output/final.contigs.fa -o /data/metabat_output

echo "Genome binning is completed"
