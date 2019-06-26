# ControlFreec

## Instructions for running Control-FREEC on WGS data
 _This will allow you to run Control-FREEC on multiple samples on Sol_
 
 _Control-FREEC developed by Boeva Lab Group_
 
 _This pipeline by RCV and KJF_


### Install

- Install [Control-FREEC](https://github.com/BoevaLab/FREEC) to your home directory

  `git clone https://github.com/BoevaLab/FREEC.git`

- Once downloaded, run the "make" command in the src directory
- For more details, see Control-FREEC [manual](http://boevalab.com/FREEC/tutorial.html)

### Before Running
- To run Control-FREEC you will need several files:
1. Aligned SAM or BAM files (single-end or paired-end, sorted or unsorted)
2. Config file
3. Chromosome length file
   - make sure chromosome names match those in the reference genome used during aligning
4. Individual chromosome FASTA files
   - e.g. [S288C Chromosome FASTAs](https://downloads.yeastgenome.org/sequence/S288C_reference/chromosomes/fasta/)

- Make a new directory for output files 
  
  `mkdir directoryName`
  
  - the shell script will make a new folder per sample within this parent directory

- Modify Config file as necessary
  - see details [here](http://boevalab.com/FREEC/tutorial.html#CONFIG) or see my example file

- Modify controlfreec.sh and slurm file
  - edit paths in .sh file and take careful note of preserving wildcards (dot asterisk) or variables ($i5$i7) in `sed` commands
    - these edit lines in Config file, allowing it to itterate through all your samples
### Running Control-FREEC
- Make sure you've added controlfreec.sh and controlfreec.slurm.sh to Sol
- Submit the slurm job on Sol 

  `sbatch controlfreec.slurm.sh`

- If completed correctly, there will be a directory for each sample with output data

### Plotting Outputs
_This can be done individually on samples via the following command on Sol:

`cat /path/to/makeGraph.R | R --slave --args < ploidy > < *_ratio.txt >`

 - Make sure the R module is loaded and you've added the makeGraph.R script
 
_Doing this for many samples is a bit trickier and there may be a better solution than my workaround:

 - test
### Troubleshooting
- make sure chromosome fasta files end with extension ".fasta", not ".fsa"
- make sure chromosome length file ends with extension ".len"
- make sure `sed` lines are working correctly by running them alone on the command line and viewing if changes were made in the Config file
- I've noticed something odd and particular about chromosome names and file names
  - make sure the length file has *chr06* or *chrVI* and those match the headings in .fasta files (and reference genome)
  - make sure the individual chromosome fasta files are named without *chr*, e.g. 06.fasta or VI.fasta
  - see example files for clarification
