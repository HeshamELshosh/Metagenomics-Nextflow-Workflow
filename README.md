# Metagenomics Workflow

This Nextflow script performs metagenome assembly using the MEGAHIT assembler and genome binning of the assembled contigs using MetaBAT by providing input reads in FASTQ format.

## Usage

`./nextflow run metagenomics_workflow.nf --reads_1 "fasta_1_file" --reads_2 "fasta_2_file"`

## Data Download

FASTQ data files used in this task downloaded in zipped format `.gz` as following:

`wget` https://sra-pub-src-1.s3.amazonaws.com/SRR25621597/122_1.fastq.gz.1 <br>
`wget` https://sra-pub-src-1.s3.amazonaws.com/SRR25621597/122_2.fastq.gz.1
 

1. Visit [source link](link) to access the data.
2. [Add any additional steps if needed.]

[Optional: If the data is hosted on a specific platform, provide information on how to create an account or access the data through the platform.]


### Parameters

- `--reads_1`: Path to input reads file 1 in FASTQ format (required)
- `--reads_2`: Path to input reads file 2 in FASTQ format (required)

### Requirements

- Nextflow version >= 23.04.3
- Docker version >= 24.0.5

## Workflow Overview

1. Metagenome assembly using MEGAHIT
2. Genome binning using MetaBAT

## Workflow Structure

The workflow script consists of three main parts:

1. Define the processes for metagenome assembly using Megahit. 
2. Define the processes for contigs binning using MetaBAT.
3. Define the workflow structure using the `workflow` block, specifying input files and process execution order.

## Prerequisites

Before running the workflow, make sure you have the following prerequisites installed:

- Nextflow version >= 23.04.3
- Docker

You also need to ensure that you have the necessary permissions to run Docker without using `sudo`. To do this, follow these steps:

1. Add your user to the `docker` group using the following command line: 
`sudo usermod -aG docker $USER`

2. Activate the changes by executing: 
`newgrp docker`

## Output

After running the workflow, you will find the following output directories: 

- Megahit output files: `megahit_output/*` including final.contigs.fa file that contains contigs to be processed by MetaBAT.
- MetaBAT output files: `metabat_output/*` that contains contigs binning fasta files. 

## Important Notes

- Ensure that input FASTQ files are correctly specified using the `--reads_1` and `--reads_2` parameters.
- The workflow creates output directories for both Megahit and MetaBAT processes.
