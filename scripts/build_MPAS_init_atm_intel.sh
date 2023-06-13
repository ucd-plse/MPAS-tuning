#!/bin/bash

source set_MPAS_env_intel.sh

export PRECISION=double

cd $(git rev-parse --show-toplevel)

make clean CORE=init_atmosphere
make -j16 ifort CORE=init_atmosphere PRECISION="${PRECISION}"