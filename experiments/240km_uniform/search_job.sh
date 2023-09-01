#!/bin/bash
#PBS -N MPAS_master_job
#PBS -A UCDV0023
#PBS -l walltime=12:00:00
#PBS -q main
#PBS -l job_priority=regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=128:mpiprocs=128:mem=235GB

if [ -z  "$PBS_JOBNAME" ]
then
    export TMPDIR=/glade/derecho/scratch/$USER/temp
    mkdir -p $TMPDIR

    source ${PROSE_REPO_PATH}/scripts/cheyenne/activate_PROSE_environment.sh
fi

python3 ${PROSE_REPO_PATH}/scripts/prose_search.py -s setup.ini