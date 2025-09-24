#!/bin/bash
cwd=$(pwd)

for pold in $(find ${cwd} -type d -name nvt); do
    # get root path & temperature:
    pnew=$(dirname ${pold})
    temp=$(echo $(basename ${pnew}) | tr -d -c 0-9)

    # define the new path:
    pnew="${pnew}/surfens"
    rm -rf ${pnew}      # remove bad directories!
    mkdir ${pnew}
    #echo ${pnew} ${temp} ${pnew}

    # copy files:
    cp ${pold}/topol.top ${pnew}/topol.top
    cp ${cwd}/run_sodium8.sh ${pnew}/run_sodium8.sh

    # modify molecular dynamics parameters:
    sed "s/XXXXX/${temp}/g" ${cwd}/grompp.mdp > ${pnew}/grompp.mdp

    # modify last configuration (confout.gro):
    head -n -1 ${pold}/confout.gro > ${pnew}/conf.gro
    tail -n 1 ${pold}/confout.gro | awk 'END {print "   ",$1,"   ",$2,"   9.00000"}' >> ${pnew}/conf.gro

    # go to the directory:
    cd ${pnew}
    qsub run_sodium8.sh
    sleep 20
    cd ${cwd}
done
