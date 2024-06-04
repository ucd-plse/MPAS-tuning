#!/bin/bash

export PRECISION=double

cd $(dirname "$0")/../
make clean CORE=atmosphere
make -j8 gfortran GPTL=1 CORE=atmosphere PRECISION="${PRECISION}"