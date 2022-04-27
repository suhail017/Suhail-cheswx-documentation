#! /usr/bin


# This shell script execute all the required process to complete the cheswx precprocess which includes downloading the data, analysis, setting up the spatial domain, interpolation and last but not least interpolation. Keep that in mind, it requires mostly python and little bit of R to execute all the process. We are using Conda environment for all the requiristic libraries and softwares. This script is stored in order, that means you have to follow the order of the scripts to develop the cheswx product. Violating the order may cause in errors.



# Initialization


# Setting up the directory

echo "Enter the location of cheswx script directory"

read cwx_swd



echo "Enter the location of cheswx data directory"


read cwx_dwd



## Download the observational and homog file for preprocessing, the destination folder is "/cheswx/sccript_prcp/download"

cd $cwx_swd/scripts_prcp/download/

# Downloading the conda environment
wget https://github.com/suhail017/cheswx/blob/511ec63e3ddc3321ae300fa33562f5a474b230f2/Conda_env/obsio_env.yml

conda env create --file obsio_env.yml

conda activate obsio_env


# Download the GHCN-D (Details can be found in the markdown file)

## Use the following address to download updated files ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/

python download_ghcnd.py

# Download the nldas2
## You need to use conda environment py2 for running the script

wget https://github.com/suhail017/cheswx/blob/511ec63e3ddc3321ae300fa33562f5a474b230f2/Conda_env/py2.yml

conda env create --file py2.yml

conda activate py2

python download_nldas2.py


# Download the ahccd and ushcn analysis

conda activate obsio_env

python download_ahccd.py

python download_ushcn.py

# Merge gridded hourly data
cd ../data_setup/

python merge_gridded_hourly.py

# Estimate the time of observation
cd ../homog/

python estimate_tobs.py

python adjust_time_of_obs.py

## Making it Homogenize 

Rscript homog_prcp_ref.R

Rscript homog_prcp.R

# Adjust the time of observation in the observation precip file

python set_time_of_obs.py

# Script to add period-of-record daily observation counts to the station

python calc_obs_cnts_homog.py

python set_duplicate_stations.py


