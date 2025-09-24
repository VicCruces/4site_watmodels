#!/bin/bash

# define temperature range:
T0=240
Tf=370
delta=10

# define environment:
ROOT=$(pwd)
NAME="isobar_1bar/"
FILES="${ROOT}/INPUT_FILES"

MDP="isobar1bar.mdp"

# iterate over points & temperatures:
for dir in ${ROOT}/*/; do       # gets full path
    dir=$(basename ${dir})      # get only last directory or point name

    # check the only the point names:
    if [ ${#dir} -gt 11 ]; then

        for temp in $(seq ${T0} ${delta} ${Tf}); do
            path=${ROOT}/${dir}/${NAME}/${temp}K

            mkdir -p ${path}
            sed -e "s/XXXX/${temp}/g" ${FILES}/${MDP} > ${path}/grompp.mdp

        done
    fi
done
