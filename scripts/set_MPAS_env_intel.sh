#!/bin/bash
source /glade/u/home/jdvanover/precimonious-w-rose/scripts/derecho/activate_PROSE_environment.sh
module load intel-classic/2023.0.0
module load parallel-netcdf/1.12.3
module load parallelio/2.6.1
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/glade/u/home/jdvanover/gptl-8.1.1/install-intel/lib