#!/bin/bash

# Check if both arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <arg1> <arg2>"
  exit 1
fi

# Store the arguments in variables
arg1="$1"
arg2="$2"

# Print the arguments
echo "Changelog file to target: $arg1"
echo "Example to run: $arg2"

cat $arg2 > x_blacksmyth/test.elm
cd x_blacksmyth

./blacksmyth.sh

cat reforged.elm >../reforged.elm
rm test.elm
rm reforged.elm
cd ..

./smyth forge reforged.elm