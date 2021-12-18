#!/bin/bash

#PBS -l nodes=5:ppn=20
#PBS -l walltime=336:30:00
#PBS -l pmem=12gb
#PBS -j oe
#PBS -m abe
#PBS -M sfm6095@psu.edu
#PBS -A ren10_e_g_lc_default

module load gcc/8.3.1
module load openmpi

singularity exec /storage/work/s/sfm6095/cheswx/cwx Rscript /storage/work/s/sfm6095/cheswx/mpi_interp_updated.R
