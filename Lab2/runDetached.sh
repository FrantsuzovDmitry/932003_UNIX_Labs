#!/usr/bin/bash

./clean.sh

# initializeDirectories
[[ -d "script" ]] || mkdir script
[[ -d "shared" ]] || mkdir shared
[[ -f "/script/script.sh" ]] || cp "./script.sh" "./script/script.sh"

# Number of containers
n=$1
if [[ ! $n ]]; then n=1; fi

# Running the n docker-containers
for i in $(seq 1 $n)
do
    docker run -v "./script":/script -v "./shared":/shared -td lab2:latest
done

# Show files in "shared" folder in console (Ctrl + C - stop logging)
cd ./shared || exit
while true
do
    clear
    ls | xargs cat 2> /dev/null
    sleep 0.5
done

