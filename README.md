# ControlFreec

## Instructions for running Control-FREEC on WGS data
 _This will allow you to run Control-FREEC on multiple samples on Sol_
 
 _This pipeline by RCV and KJF_


### Install

- Install [Control-FREEC](https://github.com/BoevaLab/FREEC) to your home directory

  `git clone https://github.com/BoevaLab/FREEC.git`

- Once downloaded, run the "make" command in the src directory
- For more details, see Control-FREEC [manual](http://boevalab.com/FREEC/tutorial.html)
---
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
---
### Running Control-FREEC
- Make sure you've added controlfreec.sh and controlfreec.slurm.sh to Sol
- Submit the slurm job on Sol 

  `sbatch controlfreec.slurm.sh`

- If completed correctly, there will be a directory for each sample with output data
---
### Plotting Outputs for A Few Samples
- This can easily be done for a small number of samples by entering the following command on Sol (make sure R module is loaded)

`cat /path/to/makeGraph.R | R --slave --args < ploidy > < *_ratio.txt >`

### Plotting Outputs for Many Samples
- Plotting numerous samples at once is a bit trickier and there may be an easier method than what I have here:
1. You should have a bunch of directories (one per sample) each containing the outputs of Control-FREEC
2. Add the modifyRatio.sh to the directory containing those sample directories
   - this script will add the sample name and ploidy of each sample to the ratio.txt file
3. Add modifyRatioFREEC.sh and modifyRatioFREEC.slurm.sh and submit the slurm job on Sol

`sbatch modifyRatioFREEC.slurm.sh`

   - If completed correctly, each sample directory will now contain the modified ratio.txt file
   - Due to the modifyRatio code not being perfect you must do the following:
      - open all modified ratio files (now named samplename-FREEC.txt) at the same time in Notepad++, replace "space" with "tab" in all open files. Save and close them.
---
- Now open R and import those ratio files

`placeholder `

---
### Troubleshooting
- make sure chromosome fasta files end with extension ".fasta", not ".fsa"
- make sure chromosome length file ends with extension ".len"
- make sure `sed` lines are working correctly by running them alone on the command line and viewing if changes were made in the Config file
- I've noticed something odd and particular about chromosome names and file names
  - make sure the length file has *chr06* or *chrVI* and those match the headings in .fasta files (and reference genome)
  - make sure the individual chromosome fasta files are named without *chr*, e.g. 06.fasta or VI.fasta
  - see example files for clarification
