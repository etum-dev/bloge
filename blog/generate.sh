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

function findCategory ()
{
	categories=( "category:writeup" "category:tea" "category:misc" )
	for c in "${categories[@]}"
	do
		echo $c
		if grep -i $c "$datename.html"; 
		then
			echo "category $c found in $datename"
			cp $datename.html $(echo $c | cut -d ":" -f2)
		else
			continue
		fi

	done
}

plaintext=$1
echo moving file: $plaintext
datename=$plaintext$(date +"%Y-%m-%d-%M")
cp "$plaintext" "html-gen/$datename"
echo to: $datename
generatePost "$datename"
echo "<a href='$datename'> $datename</a>" >> main.html
sudo systemctl restart nginx
findCategory
