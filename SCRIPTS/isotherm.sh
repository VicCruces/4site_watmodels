#!/bin/bash

# define temperature range:
TEMP=270
p0=200
pf=1000
delta=200

# define environment:
ROOT=$(pwd)
NAME="isotherm_${TEMP}K/"
FILES="${ROOT}/INPUT_FILES"

MDP="isotherm${TEMP}K.mdp"

# iterate over points & temperatures:
for dir in ${ROOT}/*/; do       # gets full path
    dir=$(basename ${dir})      # get only last directory or point name

    # check the only the point names:
    if [ ${#dir} -gt 11 ]; then

        for press in $(seq ${p0} ${delta} ${pf}); do
            path=${ROOT}/${dir}/${NAME}/${press}bar

            mkdir -p ${path}
            sed -e "s/YYYY/${press}/g" ${FILES}/${MDP} > ${path}/grompp.mdp

        done
    fi
done
