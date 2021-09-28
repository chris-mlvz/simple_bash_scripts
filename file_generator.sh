#!/bin/bash
# This script generates files up to the indicated number


name=$1
extension=$2
filesN=$3
path=$4

error() {
  local text=$1
  echo -e $text
  exit 1
}

# Check number of parameters
checkParam() {
  local requiredParamsN=$1
  local actualParamsN=$2
  if [[ $actualParamsN != $requiredParamsN ]]; then
    error "Pass 4 parameters\nStructure: file_generator [name] [extention] [filesN] [path]"
  fi
}

# Check if the path exists
checkFolder() {
  path=$1
  if [[ ! -d $path ]]; then
    error "Error: The path doesn't exist"
  fi
}

# Check if the number of files is greater than 0
checkNFiles() {
  local filesN=$1
  if [[ $filesN -le 0 ]]; then
    error "The number of files cannot be less than 1"
  fi
}

# Generation of files
fileGenerator() {
  local name=$1
  local extension=$2
  local filesN=$3
  local path=$4
  for ((i = 1; i <= $filesN; i++)); do
    nameFile="$path/$name$i.$extension"
    if [[ ! -f $nameFile ]]; then
      $(touch $nameFile)
      echo "New file: $nameFile"
    else
      echo "File: $nameFile exist"
    fi
  done
  echo "Complete"
}

# * Main
# Cheking errors
checkParam $# 4
checkFolder $path
checkNFiles $filesN
# Generation of files
fileGenerator $name $extension $filesN $path
exit 0