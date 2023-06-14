#!/bin/bash

export PRECISION=double

cd $(git rev-parse --show-toplevel)
source ./scripts/set_MPAS_env_rose.sh
make clean CORE=atmosphere
make -j1 rose-compiler CORE=atmosphere PRECISION="${PRECISION}"