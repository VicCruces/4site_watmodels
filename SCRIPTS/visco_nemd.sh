#!/bin/bash

# load spack & gromacs:
source /home/vcruces/programs/spack/20230920-git/share/spack/setup-env.sh
spack load gromacs@2022.3

# find path with "nvt" directory:
cwd=$(pwd)
ffile='*ener.edr*'
fpattern="nvt"
for p in $(find . -type d -name ${fpattern});do
    # count number of files:
    nfiles=$(find ${p}/visco -type f -name ${ffile} | wc | awk '{print $1}')
    echo ${p} ${nfiles}

    # get temperature values:
    temp=$(basename $(dirname ${p}))
    temp=$(echo ${temp} | tr -d -c 0-9)

    # check exit code (ecode) & number of files:
    if [ ${nfiles} -lt 6 ]; then
        cd ${p}

        # create visco files:
        mkdir -p visco
        cp topol.top visco/.
        cp confout.gro visco/conf.gro
        sed "s/XXXX/${temp}/g" ${cwd}/grompp_visco.mdp > visco/grompp.mdp

        # execute gromacs:
        cd visco
        for i in `seq 1 1 3`; do
            gmx grompp -maxwarn 10
            gmx mdrun -nt 12 -cpi -cpt 120

            printf "9 10 31 0" | gmx energy -b 100 >> results.txt

            rm -f confout.gro energy.xvg md* topol.tpr traj_comp.xtc state.cpt
        done

        cd ${cwd}
    fi
done
