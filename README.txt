The whole simulation data is collected in three different compressed files:

    - 4site_watmodels-45.tar.gz     (~45GB)
    - 4site_watmodels-53.tar.gz     (~45GB)
    - 4site_watmodels-60.tar.gz     (~45GB)
    - 4site_watmodels-68.tar.gz     (~45GB)
    - 4site_watmodels-75.tar.gz     (~45GB)

Those files contain all the molecular instructions ('topol.tpr'),
trajectory files ('traj_comp.xtc') and energy files ('ener.edr').
Most of the simulations were performed with GROMACS-2018 in single precision.

The data contains all the simulation results of a huge range of thermodynamic
conditions from 230K to 370K at 1bar, or four isotherms at 270K, 300K, 330K,
and 360K from 200bar to 1000bar (note that the 1bar simulation is in the isobar).

In addition to the NpT simulations, we have also performed some NVT simulations
to calculate the viscosity or the surface tension of the isobar points.
There were two methods to calculate the viscosity: Green-Kubo equations or
non-equilibrium molecular dynamics (NEMD)[1]. We decided the Green-Kubo equations
(with simulations of 21ns length) but the molecular dynamics parameters for
the readers so they can decide which of those methods fits better for their purposes.

The molecular dynamics parameters are collected in 'INPUT_FILES.tar.gz' which is the same
for all the Zenodo's projects. In addition to that, we also attach some BASH scripts in
'SCRIPTS.tar.gz' to the readers for launching or analyzing the simulations.

[1] https://pubs.aip.org/aip/jcp/article/116/1/209/450931/Determining-the-shear-viscosity-of-model-liquids

#############################
###### DISCLAIMER ###########
#############################

All the scripts have been tested and created having all water models in a flat
environment, i.e. all water models should be in the same root path.

##########################################################################
######### PLEASE CITE OUR PUBLICATIONS OF 2024-2026 ######################
##########################################################################

Our seminal work:

==> https://pubs.acs.org/doi/full/10.1021/acs.jpclett.4c00344

The work was carried out by

    - Pavel Jungwirth: https://orcid.org/0000-0002-6892-3288
    - Hector Martinez-Seara Monet: https://orcid.org/0000-0001-9716-1713
    - Victor Cruces Chamorro: https://orcid.org/0000-0002-0394-4459

In the Institute of Organic Chemistry and Biochemistry (IOCB) in Prague, Czech Republic.
