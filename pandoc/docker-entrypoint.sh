#!/bin/sh

#--
# echo $1 # pandoc
# echo $2 # markdown dir
# echo $3 # html dir
# echo $4 # css dir
#--

cd $2
for mf in `ls *.md`
do
	$1 $mf $(ls ../$4/*.css | xargs -I{} echo "-c {}") -f markdown --self-contained -o ../$3/$(echo $mf|sed 's/\.md/\.html/')
done
