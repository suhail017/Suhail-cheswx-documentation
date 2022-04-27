

# Overview

Initially, cheswx process requires two steps to run; Preprocess and Main simulation. Before starting any of the process, we need to define some initail parameters at [cwx_config.ini](https://github.com/suhail017/cheswx-1/blob/master/cwx_config.ini) file.
Please change the line 8 and 9 for Interpolation start and end date according to your need. Change data_root location according to your local machine or HPC directory. Also change observavation start and end date (Line 6 & 7) if you plan to update the database.

## Initialization

Make sure you have downloaded and activated required conda environment for cheswx. You can find all the required conda environments in [here](https://github.com/suhail017/cheswx-1/tree/master/Conda_envs). For the most process, we are using the ``obsio_env.yml`` conda environment. 


## Running order of the ChesWx Preprocess



### 1.  Setting up the domain:
1.1 File name = setup_domain_grid.R <br />
Pre required file =  None <br />
output file = bbox_interp.shp, bbox_stns.shp,bbox_dem.cdo <br />

### 2. Downloading the Database:

2.1. File Name: download_ahccd.py <br />
Pre required file =  None <br />
output file = prcp_ahccd_’ymd’_’ymd’.csv, ahccd_stns.csv <br />

2.2. File Name: download_cpc_hrly_prcp.py <br />
Pre required file =  None <br />
output file = precip.hour.’year’.nc <br />


2.3. File Name: download_ushcn.py <br />
Pre required file =  None <br />
output file = prcp_ushcn_’ymd’_’ymd’.csv, ushcn_stns.csv <br />
**Special Note**: CPC file is last updated on 2002 at the destination website. So, No need to run the file.ahccd,ushcn are updated in the 2021 website. Please update it using obiso_env conda environement.

2.4. File Name: download_ghcnd.py <br />
Pre required file = None <br />
Output fie = obs_all_’ymd’_’ymd’.nc <br />


**Special Note**:
GHCND file is going take around 2 hours to download all the files to year 2020. make sure you have enough space (~120 GB) and stable internet connection. Make sure you have set the option download_updates=False for precprocessing. But if you want to update the observation data set, you can set it to true for download new files and update it. Make sure you have the stn_nums, tobs_prcp,tobs_tmax,tobs_tmin updated. I use the ftp file server to have it manually downloaded form the ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/ link. 


2.5. File Name : download_nldas2.py  <br />
Pre required file: None  <br />
Output file = nldas2 folder containing the year data<br />
**Special Note**:
nldas is from 1979 to 2021. Make sure it is downloaded in monthly aggregated netcdf file. To download it, you need to create a .netrc and .urs_cookies file in the $HOME directory. You need to have a earth-data login Information in your home directory. Details of the procedure can be found here (https://disc.gsfc.nasa.gov/data-access#mac_linux_wget). Its going to take 1 hour~2 hour depending on the computer speed. Also, activate conda environment python2 for this script to run. After running the download_nldas2, don't forget to run "merge_gridded_hourly.py" script to merge all the output in a single file.

### 3. Data Setup:


3.1 file name: merge_gridded_hourly.py <br />
Pre required file: 2.2 and 2.5<br />
output file: merged_cpc_hrly_prcp.nc, merged_nldas2_prcp.nc<br />

3.2 file name: calc_obs_cnts.py<br />
Pre required file: 2.4<br />
output file: obs_all_’ymd’_’ymd’.nc<br />



### 4. Homogenize :

4.1 File Name: estimate_tobs.py<br />
Pre required file: 3.1 and 3.2<br />
output file: tobs_estimates.nc<br />
**Special Note**: It will take a while to execute (~2 hours)<br />

4.2 File Name: adjust_time_of_obs.py<br />
Pre required file: 3.2 and 4.1<br />
output file: 'prcp_tobs_adj_’ymd’_’ymd’.nc<br />
**Special Note**: It will take a while  to execute (~2 hours) <br />

4.3 File Name: homog_prcp_ref.R<br />
Pre required file: 2.1 and 2.3<br />
Output file: prcp_homog_ref_’ymd’_’ymd’.nc<br />
**Special Note**: We try to create the temporal range (starting year to end year) higher than 60 years, but unable to create it due to some error. So far, we are using starting year as 1951 and ending year to 2021.
Please refer to additional document for in-details error description.

4.4. File Name: homog_prcp.R<br />
Pre required file: 4.2 and 4.3<br />
Output file: prcp_homog_’ymd’_’ymd’.nc<br />

4.5. File Name: calc_obs_cnts_homog.py<br />
Pre required file: 4.4<br />
output file: prcp_homog_’ymd’_’ymd’.nc<br />

4.6 File Name: set_time_of_obs.py<br />
Pre required file: 4.4,4.1 and 2.4 <br />
Output file: obs_all_’ymd’_’ymd’.nc<br />

4.7 File Name: set_duplicate_stations.py<br />
Pre required file: 4.4<br />
Output file: prcp_homog_’ymd’_’ymd’.nc<br />

4.8 File Name: set_previous_next_obs.py<br />
Pre required file: 4.4<br />
Output file: prcp_homog_’ymd’_’ymd’.nc<br />


## Cheswx main Simulation

It requires 2 different files to run. [mpi_interp_updated.R]( https://github.com/suhail017/cheswx-1/blob/master/mpi_interp_updated.R) and [cheswx_function.R](https://github.com/suhail017/cheswx-1/blob/master/cheswx_functions_suhail.R)
In addition, you require the prcp_homog_'ymd'_'ymd'.nc (Size is ~1.5 GB for 60 years of data) file that is generated from the cheswx preprocess part.  


It is recommanded to run the cheswx simulation in a hpc cluster as it is very computationally expensive. However, if anyone wants to play with the code,
they can run this ['interp_one_day_example.R'](https://github.com/suhail017/cheswx-1/blob/master/interp_one_day_example.Rhttps://github.com/suhail017/cheswx-1/blob/master/interp_one_day_example.R) for better understanding.
