#!/bin/bash
echo "## LOADING MPAS INTEL DEPENDENCIES"
module reset
module load intel-oneapi/2023.0.0
module load parallel-netcdf/1.12.3
module load parallelio/2.6.1