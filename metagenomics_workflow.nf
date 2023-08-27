#!/usr/bin/env nextflow

"""
Metagenomics Workflow

This Nextflow script performs Metagenome assembly using MEGAHIT assembler,
and genome binning of the assembled contigs using MetaBAT by providing input reads in FASTQ format.

Usage:
./nextflow run metagenomics_workflow.nf --reads_1 "fasta_1_file" --reads_2 "fasta_2_file"

 Parameters:
     --reads_1    Input reads file 1 (required)
     --reads_2    Input reads file 2 (required)
"""


nextflow.enable.dsl=2

// Define Metagenome assembly process using MEGAHIT

process megahit_process {
    input:
    file reads_1 
    file reads_2 

    output:
    path 'megahit_output'

    script:
    """
    uid=\$(id -u)
    gid=\$(id -g)
    mkdir -p megahit_output  # Create the output directory within the work directory
    docker run -v $PWD:/data --user \$uid:\$gid quay.io/biocontainers/megahit:1.2.9--h2e03b76_1 \
           megahit -1 /data/${reads_1.getName()} -2 /data/${reads_2.getName()} -o /data/megahit_output
    
    """
}

// Define genome binning process using MetaBAT

process metabat_process {

    input:
    path megahit_output  // Use the output path from megahit_process
    
    script:
    """  
    docker run -v $PWD/megahit_output:/data --user \$(id -u):\$(id -g) quay.io/biocontainers/metabat2:2.15--h986a166_1 \
    metabat -i /data/final.contigs.fa -o /data/metabat_output

    """	
  
}
    
workflow {
    // Define command-line options
    reads_1 = file(params.reads_1)
    reads_2 = file(params.reads_2)
    
    // Run Megahit process  
    megahit_output = megahit_process(reads_1, reads_2)
     
    // Run MetaBAT process	
    metabat_process(megahit_output)
    
}


