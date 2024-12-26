
#!/usr/env bash

insertContent() {
	# Renders the blogposts in clickable format.
	# TODO: split the files with newline. wrap in <a>.
	postlinks=$(for i in "${filearr[@]}"; do echo "<a href=\"$i\">$i</a><br>"; done)
	echo $postlinks | sed -i -E '/%%Latest%%/r/dev/stdin' main.html 
	#echo "${filearr[*]}<br>" #| sed -i -E '/%%Latest%%/r/dev/stdin' main.html   
	  
	# Nginx can handle routing to the blogpost folder ( i think )
}

delOld() {
	find html-gen/*.html -not "main.html" -not -path "html-gen/tea/*" -not -path "html-gen/misc/*" -not -path "html-gen/writeup" -mtime +10 -exec rm {} \;
}

pushCategories(){
	# i can most likely refactor this to have category as a variable.. but ill push this ver first
	for file in $(ls html-gen/tea/*.html -I "tea.html");
	do
		teafiles+=("$file");
	done

	#tpostlinks=$(for x in "${teafiles[@]}"; do $($x=$x | cut -d "/" -f 2); echo "<a href=\"$x\">$x</a><br>"; done);
	for x in "${teafiles[@]}";
	do
		y=$(echo $x | cut -d '/' -f 3);
	 echo "$y";
	 
	echo "<a href=\"$y\">$y</a><br>" | sed -i -E '/<!--PAGECONTENT-->/r/dev/stdin' html-gen/tea/tea.html
	done
}

getFiles() {
	# Renders the filenames that i then send to insertContent.
	# TODO: based on date, only list the last 5.
	for file in $(ls html-gen/*.html -I "main.html");
	#do echo "getfiles:  $file";
	do
		filearr+=("$file");
	done
	
	#echo ${filearr[*]};
	
	insertContent;
	pushCategories;
}


getFiles


