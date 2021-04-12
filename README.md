

# ChesWx Package Installaition


# Description

ChesWx (Chesapeake Bay Weather) grid contains hourly data for precipitation and temperature observations for the Chesapeake Bay watershed and the broader Mid-Atlantic regions.  `cwxr` is the R library package written completely with R language for this ChesWx datasets. It was developed for the Mid-Atlantic Regional Integrated Sciences and Assessments[MARISA](https://www.marisa.psu.edu/about/) project. It  can be downloaded from the following directory:
<https://github.com/orgs/scrim-network>
## Features

- ##### Calculate the precipitation and temperature data using Geostatistical  and Machine Learning Algorithms.
- ##### This dataset is available from 1948 to 2015 at a spatial resolution of 4 km.
- ##### To ensure temporal and spatial consistency, all input station measurements of precipitation are homogenized before interpolation. 
- ##### The data are open-source.
### To download the code in your local machine or repo, you can do the followings:
## Cloning the Repository
1. On GitHub, navigate to the main page of the repository.
2. Above the list of files, click  Code.
3. To clone the repository using HTTPS, under "Clone with HTTPS", click . To clone the repository using an SSH key, including a certificate issued by your organization's SSH certificate authority, click Use SSH, then click . To clone a repository using GitHub CLI, click Use GitHub CLI, then click .
![image1](https://drive.google.com/uc?export=view&id=1aPFKDsLSbc5wn3XriP1TpHIEvNPzBDlV))
4. Open Terminal.
![image2](https://drive.google.com/uc?export=view&id=1i4aPj5_BfrIs5-TKEDUJFv_vP0owJ5fG)
5. Change the current working directory to the location where you want the cloned directory.
6. Type git clone, and then paste the URL you copied earlier.
```sh
git clone https://github.com/suhail017/cheswx.git
```
7. Following window will appear after entering the user name and Password
![image3](https://drive.google.com/uc?export=view&id=1JkUKdPXQx9zcaqhYzstWU7XtwtIa6sc7)
which indicates the download has been sucessfully completed. 

## Downloading the Zip file





## Requirements

#### To run the cheswx package, following libraries are required :
| Library Name     | Cran-Project | Devtools | R-version|Dependencies|
| ----------- | ----------- | -------|---------|--------|
| [Rmpi](https://cran.r-project.org/web/packages/Rmpi/index.html)    | Yes      | Not required|R (≥ 2.15.1)
| [ncdf4](https://cran.r-project.org/web/packages/ncdf4/index.html)  | Yes      | Not required|R (≥ 2.15.1)
| [hdf5r](https://cran.r-project.org/web/packages/hdf5r/index.html)  | Yes      | Not required|R (≥ 3.2.2)|methods
| [obsdbr](https://github.com/scrim-network/obsdbr)   | No      |  Required|R (≥ 3.4.0)|[reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [spacetime](https://cran.r-project.org/web/packages/spacetime/index.html), [stringr](https://cran.r-project.org/web/packages/stringr/index.html)
| [raster](https://cran.r-project.org/web/packages/raster/index.html)  | Yes      | Not required|R (≥ 3.5.0)|[sp](https://cran.r-project.org/web/packages/sp/index.html)  (≥ 1.4.1)|
| [RNetCDF](https://cran.r-project.org/web/packages/RNetCDF/index.html)   | Yes      | Not required|R (≥ 3.0.0)
| [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html)    | Yes      | Not required|R (≥ 3.5.0)|methods, [sp](https://cran.r-project.org/web/packages/sp/index.html) (≥ 1.1-0)
| [gstat](https://cran.r-project.org/web/packages/gstat/index.html)  | Yes| Not required| R (≥ 2.10)|[zoo](https://cran.r-project.org/web/packages/zoo/index.html), [spacetime](https://cran.r-project.org/web/packages/spacetime/index.html) (≥ 1.0-0), [FNN](https://cran.r-project.org/web/packages/FNN/index.html)|
| [lattice](https://cran.r-project.org/web/packages/lattice/index.html) | Yes      | Not required| R (≥ 3.0.0)|
| [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) | Yes      | Not required|R (≥ 3.2)|methods, [sp](https://cran.r-project.org/web/packages/sp/index.html) (≥ 1.1-0)|
| [ROSE](https://cran.r-project.org/web/packages/rgdal/index.html)  | Yes      | Not required| R (≥ 3.5.0)|
| [DMwR2](https://cran.r-project.org/web/packages/DMwR2/index.html)   | Yes      | Not required|R (≥ 3.0)|methods|
| [caret](https://cran.r-project.org/web/packages/caret/index.html) | Yes      | Not required|R (≥ 3.2.0)|[lattice](https://cran.r-project.org/web/packages/lattice/index.html) (≥ 0.20), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)|
| [doparallel](https://cran.r-project.org/web/packages/doparallel/index.html)  | Yes      | Not required|R (≥ 2.14.0)|[foreach](https://cran.r-project.org/web/packages/foreach/index.html) (≥ 1.2.0), [iterators](https://cran.r-project.org/web/packages/iterators/index.html) (≥ 1.0.0), parallel, utils|
| [foreach](https://cran.r-project.org/web/packages/foreach/index.html)  | Yes      | Not required|R (≥ 2.5.0)|
|[sp](https://cran.r-project.org/web/packages/foreach/index.html)|Yes|Not required|R (≥ 2.5.0)
| [cwxr](https://github.com/scrim-network/obsdbr)   | No      |  Required|R (≥ 3.5.0)





# How to install the prerequestic library
- Open the terminal and fire up the R
![image4](https://drive.google.com/uc?export=view&id=1eLDUvW36pqZulk7Mon0vBHUImeQuPB7m)
- Type the following command to installed any given library 
```
>install.packages('lattice')     #You can put any library name inside the parenthesis
```
- After successfully installation, you can see the below message
![image5](https://drive.google.com/uc?export=view&id=1er2eLbINFpq3Q5Kmd-gZO4Kc2Mo3E_0_)
- To verify if the library installed successfully, you can run the following command, which will load without any error message if installed correctly.
``` 
>library('lattice')
```
#### Notes: 
Some libraries will require  additional libraries to installed depending on the OS you are using. You can always installed those libraries by following the same command above or your OS terminal.  

## Using devtools
Some of the mentioned libraries(e.g. cwxr, obsdbr) are not available at cran repository. To install them, you have to install `devtools` library first at your local machine. You can do it in the traditional way:
```
install.packages('devtools')
```
Installation may take a while. When it’s finished, near the end of the installation output, we should see:
```
...
** testing if installed package can be loaded
* DONE (devtools)
```
After installing the `devtools` package, download or `git clone` the `cwxr` package from this [link](www.github.com/suhail017).
After downloading or cloning the package to your local machine, You can use the following command to install 
```
install_local(path, subdir = NULL, ..., quiet = FALSE)
```
where 
path = path to local directory, or compressed file (tar, zip, tar.gz tar.bz2, tgz2 or tbz)
subdir = subdirectory within url bundle that contains the R package.
... = Other arguments passed on to `install.packages`
quiet if  `TRUE`  suppresses output from this function.

#### Notes
For additional informations about how to install devtools, please go to this [link](https://www.digitalocean.com/community/tutorials/how-to-install-r-packages-using-devtools-on-ubuntu-18-04) and the other 
[link](https://uoftcoders.github.io/studyGroup/lessons/r/packages/lesson/).


## Notes
### Installing a package in a personal directory

If you wish to install your package somewhere other than the standard location (which may be write-protected), you need to do two things.

- create a file called  `~/.Renviron`  containing the following line:

```
R_LIBS=/path/to/Rlibs

```

replacing  `/path/to/Rlibs`  with the path that you want to use. For example, I use  `/home/suhail/Rlibs`.

-  run  `R CMD INSTALL`  at the command line, use the flag  `--library=/path/to/Rlibs`, as follows:

```
R CMD INSTALL --library=/path/to/Rlibs brocolors_0.1.tar.gz

```
where brocolors is the package name.

If you install the package using  `devtools::install()`, you just need the  `~/.Renviron`  file; you don’t need to do anything different with the  `install()`  command. devtools will use the path defined by the  `R_LIBS`  variable.
