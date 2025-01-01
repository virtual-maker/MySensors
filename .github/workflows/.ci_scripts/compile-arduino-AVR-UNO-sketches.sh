#!/bin/bash

# Define the path to the blacklist file
EXCLUDES_FILE="./.github/workflows/.ci_scripts/Arduino-AVR-UNO-excludes"

# Read the blacklist file into an array
if [ -f "$EXCLUDES_FILE" ]; then
  mapfile -t excludes < "$EXCLUDES_FILE"
else
  excludes=()
fi

echo "Excluded files:"
echo "${excludes[@]}"
echo "<END>"

# Find all .ino files and compile each one, excluding those in the blacklist
find ./examples -name "*.ino" | while read sketch; do
  if [[ ! " ${excludes[@]} " =~ " ${sketch} " ]]; then
    echo "Compiling $sketch"
    arduino-cli compile --fqbn arduino:avr:uno "$sketch"
  else
    echo "Skipping $sketch (blacklisted)"
  fi
done
