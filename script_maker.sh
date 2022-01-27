#!/bin/bash
file=mpi_interp_updated.R

nngh_pop=$1
nngh_amt=$2
nmax=$3


#var="nngh_pop<-200"
#sed -i "92s/.*/$var/" mpi_interp_updated.R
sed -i '92s/.*/nngh_pop='$nngh_pop'/' $file
sed -i '93s/.*/nngh_amt='$nngh_amt'/' $file
sed -i '94s/.*/nmax='$nmax'/' $file


cat >> cheswx_run_"nngh_pop$1"_"nngh_amt$2"_"nmax$3".sh <<EOL

#PBS -l nodes=3:ppn=20
#PBS -l walltime=00:30:00
#PBS -l pmem=12gb
#PBS -j oe
#PBS -m abe
#PBS -M sfm6095@psu.edu
#PBS -A ren10_e_g_lc_default

module load gcc/8.3.1
module load openmpi

singularity exec /storage/home/sfm6095/cheswx_update_2020Dec/sfm6095_ren10/cwx Rscript /storage/home/sfm6095/cheswx_update_2020Dec/sfm6095_ren10/mpi_interp_updated.R


EOL


qsub cheswx_run_nngh_pop$1_nngh_amt$2_nmax$3.sh
