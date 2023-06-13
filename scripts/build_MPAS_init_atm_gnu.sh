#!/bin/bash

source set_MPAS_env_gnu.sh

export PRECISION=double

cd $(git rev-parse --show-toplevel)

make clean CORE=init_atmosphere
make -j16 gfortran CORE=init_atmosphere PRECISION="${PRECISION}"