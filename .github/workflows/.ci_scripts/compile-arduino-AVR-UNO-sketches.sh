#!/bin/bash

# Fully Qualified Board Name (FQBN) of the board to compile for
FQBN="$1" # "arduino:avr:uno"
# path to the sketches directory
SKETCHES="$2" # "./examples"
# Define the path to the blacklist file
EXCLUDES="$3" # "./.github/workflows/.ci_scripts/Arduino-AVR-UNO-excludes"

# Read the blacklist file into an array
if [ -f "$EXCLUDES" ]; then
  mapfile -t excludes < "$EXCLUDES"
else
  excludes=()
fi

#### Debugging output
#echo "Excluded files:"
#echo "${excludes[@]}"
#echo "<END>"

# Find all .ino files and compile each one, excluding those in the blacklist
#find ./examples -name "*.ino" | while read sketch; do
#  if [[ ! " ${excludes[@]} " =~ " ${sketch} " ]]; then
#    echo "Compiling $sketch"
#    arduino-cli compile --fqbn arduino:avr:uno "$sketch"
#  else
#    echo "Skipping $sketch (blacklisted)"
#  fi
#done

# Find all .ino files and compile each one, excluding those in the blacklist
find "$SKETCHES" -name "*.ino" | while read sketch; do
  if [[ ! " ${excludes[@]} " =~ " ${sketch} " ]]; then
    echo "Compiling $sketch"
    arduino-cli compile --fqbn "$FQBN" "$sketch"
  else
    echo "Skipping $sketch (blacklisted)"
  fi
done
