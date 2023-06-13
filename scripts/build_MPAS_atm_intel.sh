#!/bin/bash

source set_MPAS_env_intel.sh

export PRECISION=double

cd $(git rev-parse --show-toplevel)

make clean CORE=atmosphere
make -j16 ifort CORE=atmosphere PRECISION="${PRECISION}"