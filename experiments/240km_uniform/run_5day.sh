#!/bin/bash

mpirun -n 8 --timeout 3000 --allow-run-as-root ../../atmosphere_model
cat log.atmosphere.0000.out