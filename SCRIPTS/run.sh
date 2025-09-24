#!/biin/bash
FILE='/home/vcruces/PROJECTS/praha/PAPER2/DATA/0b315989f878/TOPOL.TOP'

# compile GROMMACS:
[ ! -e topol.tpr ] && gmx grompp ${FILE} -maxwarn 10

## MPI option:
#[ ! -e confout.gro ] && gmx mdrun -cpi state.cpt -ntmpi 12 -cpt 180 -maxh 24 -dlb auto -c ${fcheck2}

# same node:
[ ! -e confout.gro ] && gmx mdrun -cpi state.cpt -nt 12 -cpt 180 -maxh 24 -dlb auto -c ${fcheck2}
