#!/usr/bin/env bash




function generatePost ()
{
	output="html-gen/"
	if [ ! -d html-gen/ ]
  then
	mkdir -p html-gen
	fi
	cd html-gen
  vim -s ../commands.txt $datename
	#cat $1 | vim -E -s -c "let g:html_no_progress=1" -c "TOhtml" -c "w $output" 
}

plaintext=$1
echo moving file: $plaintext
datename=$plaintext$(date +"%Y-%m-%d-%M")
cp "$plaintext" "html-gen/$datename"
echo to: $datename
generatePost "$datename" 
