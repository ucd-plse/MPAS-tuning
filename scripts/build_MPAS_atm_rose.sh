#!/bin/bash

source set_MPAS_env_rose.sh

export PRECISION=double

cd $(git rev-parse --show-toplevel)

make clean CORE=atmosphere
make -j1 rose-compiler CORE=atmosphere PRECISION="${PRECISION}"