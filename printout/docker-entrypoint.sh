#!/bin/bash

#--
# echo $1 # html dir
# echo $2 # pdf dir
#--

for hf in `ls $1/*.html`
do
	pf=`basename $hf`
	python3 /root/main.py $hf $2/$(echo $pf | sed 's/\.html/\.pdf/')
done
