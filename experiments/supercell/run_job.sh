#!/bin/bash
#PBS -N MPAS_supercell_run_job
#PBS -A UCDV0023
#PBS -l walltime=00:15:00
#PBS -q regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=36:mpiprocs=32:mem=45GB
#PBS -l inception=login

export TMPDIR=/glade/scratch/$USER/temp
mkdir -p $TMPDIR

make clean

timeout 600 mpirun -n 32 ../../atmosphere_model
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