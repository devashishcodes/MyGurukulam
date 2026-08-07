#!/bin/bash

template="$1"
shift

content=$(cat "$template")

for arg in "$@"
do
    key=${arg%=*}
    value=${arg#*=}

    content=$(echo "$content" | sed "s/{{${key}}}/$value/g")
done

echo "$content"