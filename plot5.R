#Set working directory to your repo locatoin
#setwd('PATH TO REPOSITORY HERE')


# get the file url
url= paste('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip')
# create a temporary directory
td = tempdir()
# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# download into the placeholder file
download.file(url, tf)
# get the name of the first file in the zip archive
fname1 = unzip(tf, list=TRUE)$Name[1]
fname2 = unzip(tf, list=TRUE)$Name[2]
# unzip the file to the temporary directory
unzip(tf, files=fname1, exdir=td, overwrite=TRUE)
unzip(tf, files=fname2, exdir=td, overwrite=TRUE)
# fpath is the full path to the extracted file
fpath1 = file.path(td, fname1)
fpath2 = file.path(td, fname2)
scc = readRDS(fpath1)
pm25 = readRDS(fpat1)

install.packages('tidyverse')
library(tidyverse)
df1 <- left_join(pm25, scc)
df1 <- df1 %>% group_by(year, type) %>% 
  dplyr::filter( fips %in% c('24510','06037') & EI.Sector %in% unique(df1$EI.Sector)[grep('On-Road', unique(df1$EI.Sector))]) %>%  
  group_by(year, fips) %>%
  dplyr::summarise(Total_Emissions=sum(Emissions, na.rm=TRUE))
png(file='plot5.png')
g <-ggplot(df1, aes(year, Total_Emissions, group=fips))
g+ geom_line(aes(color=fips)) + geom_point(aes(color=fips))
dev.off()
