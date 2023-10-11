#!/bin/bash

# Define usage function
usage() {
    echo " Changes BEAST XML Chain Length, logLength and filename accordingly, by Gautier Richard, 11/10/2023.
 Usage: $0 
    [ -i ] BEAST XML file name. Mandatory. Example: -i test_200m.xml
    [ -o ] Output file name for the edited BEAST XML file (and subsequent file names generated when running the BEAST analysis). Example: -o test_50m.xml
    [ -l ] Length of the MCMC Chain, and will edit the log chain length by making sure 10 000 logs are generated. Example: -l 50000000
    [ -h ] Prints help."
}


# Parse arguments with getopt
while getopts "i:o::l::h" opt; do
  case $opt in
    i)
      arg_i="${OPTARG}"
      ;;
    o)
      arg_o="${OPTARG}"
      ;;
    l)
      arg_l="${OPTARG}"
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
  echo "[ ERROR  ] No input XML file provided."
  usage
  exit 1
fi

fileName="$(basename ${arg_i} .xml)"
newName="$(basename ${arg_o} .xml)"

logLength=$(expr "$arg_l" / 10000)

sed 's;id="mcmc" chainLength=".*";id="mcmc" chainLength="'$arg_l'";g' $arg_i | sed 's;id="fileLog" logEvery=".*" fileName;id="fileLog" logEvery="'$logLength'" fileName;g' | sed 's;id="treeFileLog" logEvery=".*" fileName;id="treeFileLog" logEvery="'$logLength'" fileName;g' | sed '/log id="'$fileName'/ s;logEvery=".*" fileName;logEvery="'$logLength'" fileName;g' | sed 's;'$fileName';'$newName';g' > $arg_o



