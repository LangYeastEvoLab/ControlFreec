#!/bin/bash

# Modify for each use 
     # --mail-user = USR@ADDRESS.EDU
     # Export path to directory containing modifyRatio script and freecAlter shell script

#SBATCH --partition=lts
#SBATCH --qos=nogpu
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=freecAlter
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nnn@lehigh.edu

module load r-project/3.5.3
export PATH=$PATH:/share/ceph/gil213group/rcv216/sec53
modifyRatioFREEC.sh
exit
