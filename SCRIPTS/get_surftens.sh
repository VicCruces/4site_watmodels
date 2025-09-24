#!/bin/bash

# load spack & gromacs:
source /home/vcruces/programs/spack/20230920-git/share/spack/setup-env.sh
spack load gromacs@2022.3

# find path with surftens directory:
cwd=$(pwd)
for path in $(find . -type d -name "surftens"); do
    cd ${path}

    # execute gromacs analysis:
    printf "Potential\n Temperature\n #Surf*SurfTen\n" | gmx energy -b 1000 > surftens.dat
    #rm \#energy.xvg.*

    cd ${cwd}
done
