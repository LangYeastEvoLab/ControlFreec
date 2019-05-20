#!/bin/bash

# Modify for each use 
     # --mail-user = YourEmail@lehigh.edu
     # Export path to directory containing splitter script

#SBATCH --partition=lts
#SBATCH --qos=nogpu
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=controlfreec
#SBATCH --mail-type=ALL
#SBATCH --mail-user=YourEmail@lehigh

module load bwa/0.7.15 samtools/1.4 bamtools/2.4.1
export PATH=$PATH:/PATH/TO/CONTROLFREEC/SHELLSCRIPT
controlfreec.sh
exit