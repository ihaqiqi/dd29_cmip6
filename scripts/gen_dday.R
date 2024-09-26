
# Generate degree days from daily raster files of tmax and tmin

# inputs from other scripts and init:
# -- tmax.file (daily by year)
# -- tmin.file (daily by year)
# -- temp.dir
# -- out.dir
# -- j (temperature threshold)
# -- ndays

library(terra)

# ---- (1) read input files into raster ----
  tmax.year = rast(tmax.file)
  tmin.year = rast(tmin.file)

# ---- (2) calculate degree days above threshold  for each day ---
  print(tmax.file)
  
  # List all files in the temp directory
  temp.files <- list.files(temp.dir, full.names = TRUE)
  
  # Delete all files
  unlink(temp.files)
        
  for (day in 1:ndays){
    
    print(paste("day", day, " of ", ndays))
    print(" ================== ")
    
    
    # Note tmin and tmax should have same spatial features like extent and crs
    tmax = tmax.year[[day]]
    tmin = tmin.year[[day]]
    
    # computing 1st formula, if tmin > b"
    b = j +273.15
    formula_1  <- (tmax+tmin)/2- b
    cos.t      <- (2*b-tmax-tmin)/(tmax-tmin)
    
    # computing 2nd formula, if tmin < b"
    tbar       <- acos(cos.t)
    formula_2  <- ((tbar/pi)*((tmax+tmin)/2- b))+((tmax-tmin)*sin(tbar)/(2*pi))
    formula_2[is.na(formula_2)] =0
    
    # generate a zero raster object
    zeros = tmax-tmax
    
    index_1 = zeros
    index_1[tmax > b & tmin > b] = 1
    
    index_2 = zeros
    index_2[tmax > b & tmin < b] = 1
    
    # computing degree days"
    dd  <- zeros + formula_1* index_1 + formula_2*index_2 
    dd[is.na(dd)] = 0
    

    # writing temporary files
    dday.file = paste0(temp.dir, "dd", j, "_", sprintf("_%03d", day), ".nc")
    
    long.name = paste0("DegreeDaysAbove",j,"C")
    
    writeCDF(dd, filename = dday.file, overwrite=T, longname= long.name)
    
  }
  
# ---- (3) stacking daily files into one raster for each year ----  
  
  dday.file.days = paste0(temp.dir, "dd", j, "_", sprintf("_%03d",1:ndays), ".nc")
  
  # stacking all day layers to one file 
  dday = rast(dday.file.days)
  
  # Write the file
  dday.file.year = paste0(dday.dir, scn, "/dd", j ,"/dd", j, "_", file.name)
  long.name = paste0("DegreeDaysAbove",j,"C")
  writeCDF(dday, filename = dday.file.year, overwrite=T, longname= long.name, compression =5)
        
