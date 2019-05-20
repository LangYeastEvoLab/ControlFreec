#!/bin/bash

#Script to use Control-FREEC to identify CNVs from WGS data
#RCV 5/20/2019 (with help from KJF)
#Modify config file as necessary (for more info see: Chttp://boevalab.com/FREEC/tutorial.html)
#Be careful! Make sure the sed lines won't rename any other paths in the config file (i.e. make sure BAM files, chr files, and output files exist in separate directories)
#When changing paths on this script, be sure to preserve the .* wildcards and $i5$i7 variables


for i5 in N502 N503 N504 N505 N506 N507 N508 N517 S513
do
	for i7 in N701 N702 N703 N704 N705 N706 N707 N708 N709 N710 N711 N712 N716 N718 N719 N720 N721 N722 N723 N724 N726 N727 N728 N729
	do
	
	mkdir /PATH/TO/OUTPUT/DIRECTORY/$i5$i7
	
	sed -i "s|PATH/TO/OUTPUT/DIRECTORY/.*|PATH/TO/OUTPUT/DIRECTORY/$i5$i7|g" /PATH/TO/CONFIG/FILE/.txt
	
	sed -i "s|PATH/TO/BAM/FILES/.*|PATH/TO/BAM/FILES/$i5$i7\-sorted.bam|g" /PATH/TO/CONFIG/FILE/.txt
	
	/PATH/TO/FREEC/EXECUTABLE/freec -config /PATH/TO/CONFIG/FILE.txt
	
	done
done
