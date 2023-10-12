# beast_tools
BEAST Tools - various scripts to help with BEAST Phylodynamic Analyses

## Description

**make_markov_jumps_xml.R**: Rscript that should be opened preferably with RStudio that allows the automatic generation of Markov Jumps XML instructions to copy and paste in BEAST XML files.

**edit_chain_length_xml.sh**: Command Line script that takes as input a BEAST XML file to which you change the MCMC Chain length as well as the tree logs (so that 10 000 trees are generated).

**spread3_rendering_fixer.sh**: Command Line script that takes as input a SpreaD3 output renderer folder to fix the files so that SpreaD3 loads properly in recent versions of web browsers like Firefox.

**markov_jumps_plotter.R**: Rscript that should be opened with RStudio, takes as input the Markov Jumps values directly copied from Tracer (3 columns) and pasted and saved as a tab-delimited text file to make a customisable heatmap plot.

## Installation

You can git clone this repository or click "<> Code > Download Zip" and extract it somewhere easily accessible to launch the scripts from the extract folder.

