#!/bin/bash -e

[[ ! "$1" =~ \.c$|\.cpp$ ]] && { echo "File cannot be compiled"; exit 2; }

#Analog
#if [[ ! "$1" =~ \.c$|\.cpp$ ]]; then
#    echo "File cannot be compiled"
#    exit 2
#fi

temp_dir=$(mktemp -d) || exit 1
trap 'rm -rf "$temp_dir"' EXIT HUP INT QUIT TERM PIPE
LANG=C
out_file=$((grep '// Output:' $1 || grep '//Output:' $1 || grep '// output:' $1 || 
grep '//output:' $1) | cut -d ':' -f 2)
[ -z "$out_file" ] && { echo "File name not found in the file"; exit 3; }

#Analog
#if [ -z "$out_file" ]; then
#    echo "Syntax error in filename"
#    exit 3
#fi

gcc -o "$temp_dir/$out_file" "$1" -lstdc++ && mv "$temp_dir/$out_file" ./ && echo "Successful"