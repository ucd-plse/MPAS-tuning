#!/bin/bash

source set_MPAS_env_gnu.sh

export PRECISION=double

cd $(git rev-parse --show-toplevel)

make clean CORE=atmosphere
make -j16 gfortran CORE=atmosphere PRECISION="${PRECISION}"