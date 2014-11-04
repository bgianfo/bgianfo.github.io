#!/bin/bash 

# Define our usage function.
usage()
{
	echo "Usage: $0	<pdf-file-name>"
	exit 1
}

# Define is_file_exits function 
# $f -> store argument passed to the script
is_file_exits()
{
	local f="$1"
	[[ -f "$f" ]] && return 0 || return 1
}

if [[ $# != 1 ]]; then
	usage
fi

if ( is_file_exits "$1" )
then
	file=$1
	destfilename=${file%.*}-thumb.png
	convert -thumbnail 500 $file[0] $destfilename
else
 	echo "File not found: $1"
	exit 1
fi
