#!/bin/bash

# define temperature range:
T0=270
Tf=370
delta=10

# define environment:
ROOT=$(pwd)
NAME="isobar_1bar/"
FILES="${ROOT}/INPUT_FILES"

MDPFILE='nvt.mdp'
OUTFILE='confout.gro'
SUMFILE='analysis/summary.dat'

# iterate over points & temperatures:
for dir in ${ROOT}/*/; do       # gets full path
    dir=$(basename ${dir})      # get only last directory or point name

    # check the only the point names:
    if [ ${#dir} -gt 11 ]; then

        for temp in $(seq ${T0} ${delta} ${Tf}); do
            path=${ROOT}/${dir}/${NAME}/${temp}K

            cd ${path}

            mkdir -p nvt
            boxx=$(awk 'FNR == 10 {print $2}' ${SUMFILE})

            # prepare simulation setup:
            mkdir -p nvt
            head -n -1 ${OUTFILE} > nvt/conf.gro
            echo "   ${boxx}   ${boxx}   ${boxx} " >> nvt/conf.gro
            sed "s/XXXX/${temp}/g" ${FILES}/${MDPFILE} > nvt/grompp.mdp

            cd ${ROOT}

        done
    fi
done
