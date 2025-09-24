#!/bin/bash

cwd=$(pwd)
ROOT="/home/vcruces/PROJECTS/praha/PAPER2/DATA"

for dir in ${ROOT}/*/; do
    dir=$(basename ${dir})

    if [ ${#dir} -gt 11 ]; then
        mkdir -p ${dir}
        cp ${ROOT}/${dir}/TOPOL.TOP ${dir}/.
        cp ${ROOT}/${dir}/INDEX.NDX ${dir}/.
    fi
done
