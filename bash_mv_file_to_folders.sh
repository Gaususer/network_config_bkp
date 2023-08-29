#!/bin/bash

# 20230827 pavel galeev for Harmonicinc
# ver 03 - prod ver 01

sdir="/var/ftp"                                 # source dir
fna=$(ls $sdir)                                 # file name array

marker="_"
lmarker=${#marker}
hn_old=""                                       # last host name

for file in $fna ; do
	if [[ -d $file ]]; then                  # if "file" is "dir" then next 
		continue
	else
		lfr=0
		lfn=${#file}                            # length file name
		fnr=${file#*$marker}                    #        file name residue
		lfr=${#fnr}                             # length file name residue
		if [[ ! $lfn -eq $lfr ]]; then          # if markek found
			#--------------------------------------
			lhn=$(( $lfn - $lfr - $lmarker))                    # length host name
			hn=${file:0:lhn}                                    # host name
			#--------------------------------------
			if [[ $hn_old = $hn ]];then continue; fi            # the name is repeated
			#--------------------------------------
			if [[ ! -d $sdir$hn ]]; then mkdir $sdir$hn ; fi    # create the folder if it didn't already exist
			#-------------------------------------
			src="$sdir""$hn""_*"
			dst="$sdir""$hn""/"
			command mv $src $dst
		fi
	hn_old=$hn
	fi
done
