#!/bin/bash

mpirun -n 8 --timeout --allow-run-as-root ../../atmosphere_model
cat log.atmosphere.0000.out