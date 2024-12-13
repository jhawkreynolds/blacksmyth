#!/bin/bash

# Check if both arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <oldProgram> <changelog> or $0 <oldProgram> <changelog> <oracle>"
  exit 1
fi

# Store the arguments in variables
oldProgram=$1
changelog=$2
oraclepath=$3

# Print the arguments
echo "Example to run: $oldProgram"
echo "Changelog file to target: $changelog"
if [ -z "$3" ]; then
  echo "Oracle not provided, continuing"
else
  echo "Oracle used: $oraclepath"
fi

oracle=$(basename $oraclepath)

cat $oldProgram > x_blacksmyth/test.elm
cat $changelog > x_blacksmyth/changelog.txt
if [ -z "$3" ]; then
  true
else
  cat $oraclepath > x_blacksmyth/$oracle
fi

cd x_blacksmyth

if [ -z "$3" ]; then
  ./blacksmyth.sh test.elm changelog.txt
else
  ./blacksmyth.sh test.elm changelog.txt $oracle
fi

cat reforged.elm

cat reforged.elm >../reforged.elm
rm test.elm
rm reforged.elm
rm changelog.txt
if [ -z "$3" ]; then
  true
else
  rm $oracle
fi

cd ..

./smyth forge reforged.elm