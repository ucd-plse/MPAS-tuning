#!/bin/bash

export PRECISION=double

cd $(git rev-parse --show-toplevel)
source ./scripts/set_MPAS_env_gnu.sh
make clean CORE=init_atmosphere
make -j16 gfortran CORE=init_atmosphere PRECISION="${PRECISION}"