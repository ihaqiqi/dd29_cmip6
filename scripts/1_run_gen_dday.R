
# Main: Mean and SD of Degree Days Above 29C based on NEX-GDDP-CMIP6 
# This script: set up parameters to calculate degree days

# Load required packages
library(terra)
library(tidyr)

terraOptions(memfrac=0.4)

# directories for input and output data
data.dir = "../git/data/"
temp.dir = "../git/temp/"
dday.dir = "../git/dday/"

# select the threshold(s)
degree.list = c(29)
# 10, 20, 29, 30

# select scenario(s)
scenario.list = c("historical", "ssp585", "ssp245")

# select model(s)
mod.list = 
  c("ACCESS-CM2", "ACCESS-ESM1-5", "BCC-CSM2-MR", "CanESM5", "CMCC-CM2-SR5", 
  "CMCC-ESM2", "EC-Earth3", "EC-Earth3-Veg-LR", "GFDL-CM4_gr2", "GFDL-CM4", 
  "GFDL-ESM4", "IITM-ESM", "INM-CM4-8", "INM-CM5-0", "IPSL-CM6A-LR", 
  "KACE-1-0-G", "KIOST-ESM", "MIROC6", "MPI-ESM1-2-HR", "MPI-ESM1-2-LR", 
  "MRI-ESM2-0", "NESM3", "NorESM2-LM", "NorESM2-MM", "TaiESM1")


# loop over scenarios and models
# Note: this is based on original file names from NEX-GDDP-CMIP6 

for (j in degree.list){
  for (scn in scenario.list){
    
    # list of years to be included
    year_list = c(2035:2064)
    
    if (SCN == "historical") {year_list = c(1985:2014)}
    
    # find the files available in data directory assuming tasmin is also there!
    files.df = data.frame(list.files(paste0(data.dir, scn, "/tasmax/")))
    
    names(files.df) = "FILE"
    
    # create a data frame with file details
    names.df <- files.df %>%
      separate(FILE, into = c("VAR", "FRQ", "MOD", "SCN", "FRC", "GN", "YEAR.NC" ), sep = "_")
    
    files.df <- cbind(files.df, names.df)
    
    files.df$YEAR = as.numeric(substr(names.df$YEAR.NC, 1, 4))
    
    head(files.df)
    
    df = subset(files.df, MOD  %in% mod.list)
    
    df = subset(files.df, YEAR  %in% year.list)
    
    N = length(df$FILE)
    
    # calculate degree days file by file
    for (n in 1:N){
      
      f = df[n,]
      
      print(f)
      
      file.name = paste(f$FRQ, f$MOD, f$SCN, f$FRC, f$GN, f$YEAR.NC, sep="_")
      
      file.name
      
      tmax.file = paste0(data.dir, scn, "/tasmax/tasmax_", file.name)
      
      tmin.file = paste0(data.dir, scn, "/tasmin/tasmin_", file.name)
      
      ndays = 365
      
      source("../git/scripts/gen_dday.R")
      
    }
  }
}

    