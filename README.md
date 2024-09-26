# Growing Degree Days based on NEX-GDDP-CMIP6 Climate Projections
## Description

These scripts are used to estimate the mean and standard deviation (SD) of corn heat stress (degree days above 29°C) for around 20 climate models in NEX-GDDP-CMIP6.
A full description of methods, including growing season, daily temperature distribution, and statistical coefficients, can be found at Haqiqi, I. (2024). Trade can buffer climate-induced risks and volatilities in crop supply. Environmental Research: Food Systems. https://doi.org/10.1088/2976-601X/ad7d12

The source NEX-GDDP-CMIP6 data is described in Thrasher et al. (2022) and is available here:  https://ds.nccs.nasa.gov/thredds/catalog/AMES/NEX/GDDP-CMIP6/catalog.html

## Instructions

Step 1. Download the NEX-GDDP-CMIP6 to the data directory.

Step 2. Create daily degree days by running  scripts/1_run_gen_dday.R

Step 3. Create seasonal degree days by running scripts/2_run_ren_yearly.R

Step 3. Create mean and SD of degree days by running scripts/3_run_gen_sdev.R


You may choose a subset of models or consider different temperature thresholds.
