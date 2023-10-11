#!/bin/bash

#Source of the script: https://github.com/phylogeography/SpreaD3/issues/32#issuecomment-540692525


set -Eeuo pipefail

(
    head -n 149 < main.js
    echo -n 'json = '
    cat data.json
    echo ';'
    tail -n +156 main.js | awk 'NR != 107'
) > main-new.js

sed -e 's/main\.js/main-new.js/' < index.html > index-new.html
