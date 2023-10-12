#!/bin/bash

#Source of the script: https://github.com/phylogeography/SpreaD3/issues/32#issuecomment-540692525


# Define usage function
usage() {
    echo " Fixes SpreaD3 output for recent Web Browsers, by Terry Cojones, 06/12/2019.
 Usage: $0 
    [ -i ] SpreaD3 Output Folder Name. Example: -i path/to/Spread3_output/renderers/d3/d3renderer
    [ -h ] Prints help."
}


# Parse arguments with getopt
while getopts "i::h" opt; do
  case $opt in
    i)
      arg_i="${OPTARG}"
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done

# Check if arg_i is empty
if [ -z "$arg_i" ]; then
  echo "[ ERROR  ] No input SpreaD3 folder provided."
  usage
  exit 1
fi

set -Eeuo pipefail

(
    head -n 149 < $arg_i/main.js
    echo -n 'json = '
    cat $arg_i/data.json
    echo ';'
    tail -n +156 $arg_i/main.js | awk 'NR != 107'
) > $arg_i/main-new.js

sed -e 's/main\.js/main-new.js/' < $arg_i/index.html > $arg_i/index-new.html
