#!/bin/bash
# This script adds a prefix to files of a certain type

prefix=$1
extension=$2
path=$3
requiredParamsN=3
actualParamsN=$#
newName

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
    error "Pass 3 parameters\nStructure: add_prefix [prefix] [extention] [path]"
  fi
}

# Check if the path exists
checkPath() {
  path=$1
  if [[ ! -d $path ]]; then
    error "Error: The path doesn't exist"
  fi
}

# Add prefix
addPrefix() {
  local prefix=$1
  local extension=$2
  local path=$3
  for f in $(ls $path); do
    local oldName=$f
    local regex=*.$extension
    if [[ $oldName == $regex ]]; then
      local newName=$prefix$oldName
      $(mv $path/$oldName $path/$newName)
      echo "Added prefix: $newName"
    fi
  done
  echo "Complete"
}

# * Main
# Cheking errors
checkParam $requiredParamsN $actualParamsN
checkPath $path
# Add prefix
addPrefix $prefix $extension $path
