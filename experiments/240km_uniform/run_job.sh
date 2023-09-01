#!/bin/bash
#PBS -N MPAS_240k_uniform_run_job
#PBS -A UCDV0023
#PBS -l walltime=00:03:00
#PBS -q main
#PBS -l job_priority=regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=64:mpiprocs=64:mem=235GB

export TMPDIR=/glade/derecho/scratch/$USER/temp
mkdir -p $TMPDIR

make clean

timeout 360 mpirun -n 64 ../../atmosphere_model
status=$?
if [ $status -eq 124 ]; then
    touch ./execution_timeout
elif [ $status -eq 0 ]; then
    touch ./execution_success
else
    touch ./execution_fail
fi

cat log.atmosphere.0000.out