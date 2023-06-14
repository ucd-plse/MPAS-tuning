#!/bin/bash

export PRECISION=double

cd $(git rev-parse --show-toplevel)
source ./scripts/set_MPAS_env_intel.sh
# make clean CORE=atmosphere
make -j16 ifort CORE=atmosphere PRECISION="${PRECISION}"