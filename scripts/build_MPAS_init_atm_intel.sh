#!/bin/bash

export PRECISION=double

cd $(dirname "$0")/../
source ./scripts/set_MPAS_env_intel.sh
make clean CORE=init_atmosphere
make -j16 ifort CORE=init_atmosphere PRECISION="${PRECISION}"