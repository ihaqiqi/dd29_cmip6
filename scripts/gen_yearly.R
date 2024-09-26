
# Generate annual degree days from daily raster files of daily degree days

# inputs from other scripts and init:
# -- in.this.year file  
# -- in.next.year file
# -- dday.dir
# -- year.dir
# -- j (temperature threshold)

dday.file.daily = paste0(dday.dir, scn, "/dd", j ,"/dd", j, "_", file.name)

dday = rast(dday.file.daily)

dd.daily.a = dday * in.this.year
dd.daily.b = dday * in.next.year

dd.year.a = app(dd.daily.a, sum, ra.rm = T)
dd.year.b = app(dd.daily.b, sum, ra.rm = T)

long.name = paste0("DegreeDaysAbove", j, "C")

out.name = paste(f$MOD, f$SCN, f$FRC, f$GN, paste0(f$YEAR, ".nc"), sep="_")
out.file  = paste0(year.dir, scn, "/dd", j ,"/dd", j, "a_season_", out.name)
writeCDF(dd.year.a, filename = out.file, overwrite=T, longname= long.name, compression =5)

out.name = paste(f$MOD, f$SCN, f$FRC, f$GN, paste0(f$YEAR + 1, ".nc"), sep="_")
out.file  = paste0(year.dir, scn, "/dd", j ,"/dd", j, "b_season_", out.name)
writeCDF(dd.year.b, filename = out.file, overwrite=T, longname= long.name, compression =5)
