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
    docker run -v "./script":/script -v "./shared":/shared lab2:latest
done
