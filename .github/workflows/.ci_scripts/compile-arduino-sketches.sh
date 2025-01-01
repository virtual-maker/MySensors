#!/bin/bash
result=0

# Fully Qualified Board Name (FQBN) of the board to compile for
FQBN="$1" # "arduino:avr:uno"
# Path to the sketches directory
SKETCHES="$2" # "./examples"
# Define the path to the blacklist file
EXCLUDES="$3" # "./.github/workflows/.ci_scripts/Arduino-AVR-UNO-excludes"

# Create or overwrite the blacklist.txt file
BLACKLIST_FILE="./blacklist.txt"
> "$BLACKLIST_FILE"

# Read the blacklist file and write to blacklist.txt, ignoring lines starting with # or are whitespace only
if [ -f "$EXCLUDES" ]; then
  grep -vE '^\s*#|^\s*$' "$EXCLUDES" > "$BLACKLIST_FILE"
fi

#### Debugging output
echo "Excluded files:"
cat "$BLACKLIST_FILE"
echo "<END>"

# Find all .ino files and compile each one, excluding those in the blacklist
find "$SKETCHES" -name "*.ino" | while read sketch; do
  if ! grep -Fxq "$sketch" "$BLACKLIST_FILE"; then
    echo "Compiling $sketch"
    arduino-cli compile --fqbn "$FQBN" "$sketch" --warnings more
		compile_result=$?
    if [ $compile_result -ne 0 ]; then
      result=1
    fi

  else
    echo "Skipping $sketch (blacklisted)"
  fi
done

# Exit with error state
exit $error_state
