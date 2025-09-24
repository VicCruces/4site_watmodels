#!/bin/bash

# INPUT ARGS: check simulation
cwd=$(pwd)
fout='summary.dat'
fener='ener.edr'
ftraj='traj_comp.xtc'

# INPUT ARGS: thermodynamic props., RDF & MSD
itime=500
bin=0.002
fndx="${cwd}/INDEX.NDX'
props='Potential\n Temperature\n Pressure\n Box-X\n Density'

# check that simulation is not CORRUPTED:
if [[ ${err} == *"WARNING:"* ]] || [[ ${err} == *"Fatal error:"* ]]; then
        printf "${workdir}\n\n${err}" > SIMULATION_CORRUPTED
fi

# get thermodynamic properties:
if [ ! -e analysis/summary.dat ]; then
    printf "${props}" | gmx energy -b ${itime} \
                                   -f ener.edr \
                                   -s topol.tpr \
                                   -o analysis/energy.xvg > analysis/summary.dat
fi

# get the RDF:
if [ ! -e analysis/rdf.xvg ]; then
    printf "OW1\nOW1\n" | gmx rdf -b ${itime} \
                                  -bin ${bin} \
                                  -n ${fndx} \
                                  -s topol.tpr \
                                  -f traj_comp.xtc \
                                  -o analysis/rdf.xvg
fi

# get the MSD:
if [ ! -e analysis/msd.xvg ]; then
  printf "OW1\n" | gmx msd -b ${itime} \
                           -n ${fndx} \
                           -s topol.tpr \
                           -f traj_comp.xtc \
                           -o analysis/msd.xvg  > analysis/res_msd.dat
fi

# calculate the relative permittivity:
if [ ! -e analysis/epsilon.xvg ]; then
    printf "System\n" | gmx dipoles -b ${itime} \
                                    -temp ${temp} \
                                    -n ${fndx} \
                                    -s topol.tpr \
                                    -f traj_comp.xtc \
                                    -a analysis/aver.xvg \
                                    -o analysis/Mtot.xvg \
                                    #-g analysis/gkr.xvg \
                                    -eps analysis/epsilon.xvg \
                                    -d analysis/dipist.xvg > analysis/rel_perm.dat
fi
