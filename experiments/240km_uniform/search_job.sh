#!/bin/bash
#PBS -N MPAS_master_job
#PBS -A UCDV0023
#PBS -l walltime=12:00:00
#PBS -q main
#PBS -l job_priority=regular
#PBS -j oe
#PBS -k eod
#PBS -l select=10:ncpus=128:mpiprocs=128:mem=235GB

source ../../scripts/set_MPAS_env_intel.sh
python3 ${PROSE_REPO_PATH}/scripts/prose_search.py -s setup.ini