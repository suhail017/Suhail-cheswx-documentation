
# Example of running ChesWx precipitation interpolation/simulation for a single day
###############################################################################

Sys.setenv(TZ="UTC")
library(hdf5r)
library(cwxr)
library(obsdbr)
library(raster)
library(ncdf4)
library(RNetCDF)
library(rgdal)
library(gstat)

library(lattice)
library(ggplot2)
library(ROSE)
library(DMwR2)
library(grid)
library(caret)

library(Rmpi)
library(doParallel)
library(foreach)

    
source("/storage/home/sfm6095/work/cheswx/cheswx_functions.R")
#source("cheswx_functions.R")

################################################################################
# Define ChesWx configuration
################################################################################
#rm(list=ls())

cfg <- list()
cfg['data_root'] = '/storage/home/sfm6095/data/cheswx'
cfg['data_root_out'] = '/storage/home/sfm6095/data/cheswx'
cfg['interp_start_date'] = '1951-01-01'
cfg['interp_end_date'] = '2020-12-31'
cfg['interp_start_proc'] = '1951-01-01'
cfg['interp_end_proc'] = '2020-12-31'
cfg['wet_thres'] = 0

# Define path to station observation netcdf file
fpath_stnobs <- file.path(cfg['data_root'], 'station_data',
                          sprintf('prcp_homog_%s_%s.nc', 
                                  format(as.Date(cfg[['interp_start_date']]),"%Y%m%d"),
                                  format(as.Date(cfg[['interp_end_date']]),"%Y%m%d")))


################################################################################
# Standard parameters for multiproc function
################################################################################

# Dates for validation
date_start <- as.Date(cfg[['interp_start_date']])
date_end <- as.Date(cfg[['interp_end_date']])
date_end_proc <- as.Date(cfg[['interp_end_proc']])
date_start_proc <- as.Date(cfg[['interp_start_proc']])
dates_interp <- seq(date_start_proc, date_end_proc, by='days')
#dates_interp <- seq(date_start, date_end, by='days')
ndates <- length(dates_interp)

params <- list()
nprocs <- 20
fpath_log <- file.path(cfg['data_root_out'], 'logs', 'mpi_prcp_interp.log')
fpath_stnobs <- file.path(cfg['data_root'], 'station_data',
                                 sprintf('prcp_homog_%s_%s.nc', 
                                         format(as.Date(cfg[['interp_start_date']]),"%Y%m%d"),
                                         format(as.Date(cfg[['interp_end_date']]),"%Y%m%d")))


fpath_nc_out <- file.path(cfg['data_root_out'], 'interpolation',
                                 sprintf('cheswx_interp_prcp_%s_%s.nc', 
                                         format(date_start_proc,"%Y%m%d"),
                                         format(date_end_proc,"%Y%m%d")))

elem_interp <- 'prcp'
elems_load <- c(elem_interp, 'prcp_prev', 'prcp_next')
dates_interp <- dates_interp
a_sp <- NULL #spatial object of interpolation grid, set below
func_interp <- NULL #interpolation function, set below
rm_stnids <- NULL #station ids of stations to not use, set below
func_stns <- NULL #function to modify station metadata/covariates, set below
libs_load <- c('spacetime')
mp_type <- "PSOCK" # PSOCK or MPI

################################################################################
# Interpolation function parameters
################################################################################

nngh_pop <- 24
nngh_amt <- 8
nmax <- 10 # Max num of neighbors to use for probability conditional simulation

# configuration of what defines the best simulation
# importance of a simulation's correlation, bias, and MAE
# relative to predicted median values

importance_best_sim <- c(.5, .1, .1)
predictand <- elem_interp
stnids_subset <- NULL #station ids within interpolation domain, set below


# the date to interpolate: Tropical Storm Lee
#date_interp <- '2011-09-08'


################################################################################
# Raster Data
################################################################################

# Paths to input rasters
fpaths_rasters = c(file.path(cfg['data_root'],'raster','bbox_dem.tif'),
                   file.path(cfg['data_root'],'raster','bbox_lon.tif'),
                   file.path(cfg['data_root'],'raster','bbox_lat.tif'),
                   file.path(cfg['data_root'],'raster','bbox_mask.tif'))
fnames_rasters = c('elevation', 'longitude1', 'latitude1','mask')

fpath_dem_buf <- file.path(cfg['data_root'], 'raster', 'dem_4km_topowx_buf.tif')

# Create SPDF that defines grid for interpolation along with covariate values
a_brick <- cwxr::brick_rasters(fpaths_rasters, fnames_rasters)
a_brick_spdf <- as(a_brick, 'SpatialPixelsDataFrame')

################################################################################
# Function for station setup
################################################################################

# Open netcdf observation file
ds <- hdf5r::H5File$new(fpath_stnobs, mode='r')
# Load station metadata as SpatialPointsDataFrame
stns <- obsdbr::load_stns(ds, c("station_id", "station_name", "longitude",
                                "latitude", "elevation", "dup"))


#times <- obsdbr::load_time(ds)
#prcp <- obsdbr::load_obs(ds, 'prcp', stns, times, start_end=dates_interp)

ds$close_all()

# Get station ids that are duplicates and should not be used                        
rm_stnids <- stns$station_id[stns$dup == 1]

# Get station ids that are actually within the interpolation domain
rmask <- raster::raster(rgdal::readGDAL(file.path(cfg['data_root'], 'raster', 'bbox_mask.tif')))
mask_domain <- ((is.finite(raster::extract(rmask, stns))) & (!(stns$station_id %in% rm_stnids)))
stnids_subset <- row.names(stns)[mask_domain]  

################################################################################
# Setup of remaining parameters
################################################################################

# Standard parameters
a_sp <- a_brick_spdf
func_interp_new <- func_interp_new
rm_stnids <- rm_stnids
func_stns <- func_stns

# Interpolation function parameters
stnids_subset <- stnids_subset

# Load previously predicted pop  
#fpath_pop <- file.path(cfg['data_root'], 'interpolation', 'cheswx_interp_prcp_skipped_dates_pop_19760106_20171130.nc')
#brick_pop <- raster::brick(fpath_pop)
#spdf_pop <- as(brick_pop, 'SpatialPixelsDataFrame')
#pred_pop <- obsdbr::quick_load_stnobs(fpath_pop, 'prcp')[["prcp"]]
#pred_pop <- fpath_pop
################################################################################


run_multiproc_interp_new(nprocs, fpath_log, fpath_stnobs, fpath_nc_out, elem_interp,
                     elems_load=elems_load, dates_interp, a_sp, a_brick_spdf, func_interp_new, rm_stnids = rm_stnids,
                     func_stns=NULL, libs_load = libs_load, mp_type = mp_type, 
                     predictand=elem_interp, nngh_pop=nngh_pop,  
                     stnids_subset=stnids_subset, nngh=nngh_pop, nngh_amt=nngh_amt, nmax=nmax, importance_best_sim=importance_best_sim)
