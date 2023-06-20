#!/bin/bash
#PBS -N MPAS_run_job
#PBS -A UCDV0023
#PBS -l walltime=00:10:00
#PBS -q regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=36:mpiprocs=36:mem=45GB
#PBS -l inception=login

export TMPDIR=/glade/scratch/$USER/temp
mkdir -p $TMPDIR

make clean

timeout 300 mpirun ../../atmosphere_model
status=$?
if [ $status -eq 124 ]; then
    touch ./execution_timeout
elif [ $status -eq 0 ]; then
    touch ./execution_success
else
    touch ./execution_fail
fi

mv log.atmosphere.0000.out stdout.txt
ln -sf stdout.txt stderr.txt