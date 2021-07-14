#!/bin/bash

declare -A FILES
matches_found=false
for f in analysis/*.py
do
    matches=()
    #iterate non-commented lines in restricted function list
    for l in `grep "^[^#;]" restricted_functions.txt `
    do
        matches+=`grep -n $l $f | grep "^[0-9]*\:[^#]"`
    done
    
    #add to dict if matches found
    if [[ ${matches[@]} ]]; then
        matches_found=true
        FILES["${f}"]=$matches
    fi    
done

if "$matches_found" = true; then 
    echo "Instances of restricted function calls found:"
    for key in "${!FILES[@]}"
    do
        echo " - $key"
        matches=${FILES[$key]}
        for match in "${matches[@]}"
        do
            echo -e "\t ${match}"
        done
    done
fi