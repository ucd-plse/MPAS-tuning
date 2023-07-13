#!/bin/bash
#PBS -N MPAS_master_job
#PBS -A UCDV0023
#PBS -l walltime=12:00:00
#PBS -q regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=36:mpiprocs=36:mem=45GB
#PBS -l inception=login

if [ -z  "$PBS_JOBNAME" ]
then
    export TMPDIR=/glade/scratch/$USER/temp
    mkdir -p $TMPDIR

    source ${PROSE_REPO_PATH}/scripts/cheyenne/activate_PROSE_environment.sh
fi

python3 ${PROSE_REPO_PATH}/scripts/prose_search.py -s setup.ini