#!/bin/bash -ex

# Create a new file containing the hash digest of another file

if ! command -v shasum &> /dev/null
then
    # Assuming this script will be run on macOS where shasum
    # is available out of the box
    echo "ERROR: shasum could not be found"
    exit 1
fi

if [ $# -eq 0 ]
  then
    echo "ERROR: Need absolute path to the target file"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "WARNING: Only the first parameter will be used"
fi

absolutePathToFile=$1
if [[ $absolutePathToFile != /* ]]
then
    echo "ERROR: Please provide an absolute path to the target file"
    exit 1
fi

filename=$(basename -- "$absolutePathToFile")
directories=`dirname $absolutePathToFile`

shasum -a 256 $absolutePathToFile > $directories/$filename.sha256
echo "Successfully created hash digest at:"
echo "$directories/$filename.sha256"
