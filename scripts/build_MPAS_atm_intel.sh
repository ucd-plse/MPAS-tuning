#!/bin/bash

export PRECISION=double

cd $(dirname "$0")/../
source ./scripts/set_MPAS_env_intel.sh
# make clean CORE=atmosphere
make -j16 ifort CORE=atmosphere PRECISION="${PRECISION}"