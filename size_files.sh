#!/bin/bash
# This program calculates the size of only files in a folder

if [[ ! -d $1 ]]; then
  echo "Error: The folder does not exist"
  exit 1
fi

total=0
for f in $(ls $1); do
  name="$1/$f"
  if [[ -f $name ]]; then
    bytes=$(ls -l $name | cut -d " " -f 5)
    echo "$name (file) occupies: $bytes bytes" | tr -s /
    ((total += bytes))
  fi
done
echo -e "\nTotal bytes in folder is: $total"
