



dd_a = rast(dd_a.file)
dd_b = rast(dd_b.file)

ras_sdev =  app(dd_a + dd_b, sd, na.rm=T)
ras_mean =  app(dd_a + dd_b, mean, na.rm=T)

print( "==== Writing netCDF ====")
sdev.long.name = "StandardDeviation_DDay"
ras_sdev_file  = paste0(norm.dir, scn, "/dd", j ,"/dd", j, "sdev_", MOD,"_", SCN, ".nc")
writeCDF(ras_sdev, filename = ras_sdev_file, overwrite=T, longname= sdev.long.name)

mean.long.name = "Mean_DDay"
ras_mean_file  = paste0(norm.dir, scn, "/dd", j ,"/dd", j, "mean_", MOD,"_", SCN, ".nc")
writeCDF(ras_mean, filename = ras_mean_file, overwrite=T, longname= mean.long.name)
