#!/bin/bash -e

[[ ! "$1" =~ \.c$|\.cpp$ ]] && echo "File cannot be compiled" >&2 && exit 2

temp_dir=$(mktemp -d) || exit 1
trap 'rm -rf "$temp_dir"' EXIT HUP INT QUIT TERM PIPE
LANG=C
out_file=$(grep '// Output:' $1 | cut -d ':' -f 2)
[ -z "$out_file" ] && echo "File name not found in the file" >&2 && exit 3;

gcc -o "$temp_dir/$out_file" "$1" -lstdc++ && mv "$temp_dir/$out_file" ./
echo "Successful"
