#!/bin/bash

# Get first free filename from subsequence 001, 002 ...
getNameFromNumber () {
    printf "%03d" "$1"
}

findFreeFileName () {
    for i in {0..999}; do
        file="$(getNameFromNumber $i)"
        if [[ ! -f "$file" ]]; then
            echo "$file"
            return
        fi
    done
}

writeFile () {
    fileName=$(findFreeFileName)
    echo "$CONTAINER_ID $fileName" > "$fileName"
    echo "$fileName"
}

# Program start:
if [[ ! $CONTAINER_ID ]]; then CONTAINER_ID=$HOSTNAME; fi

cd /shared || exit

while true 
do
    if [[ $current ]]; then
        flock -s "$current" -c "rm $current"
        echo "$HOSTNAME DELETED $current"
        current=""
    else
        current=$(flock -s ".lock" -c "echo $(writeFile)")
        echo "$HOSTNAME CREATED $current"
    fi

    sleep 1
done
