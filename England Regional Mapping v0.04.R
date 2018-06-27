#v0.02 of mapping code, code requires a shapefile and input values for variable you want to display on the map
#v0.04 of mapping code, code requires a shapefile and input values for variable you want to display on the map, changed plotting method to ggplot

#install packages
if (!require(rgdal)){
  install.packages("rgdal")
  library(rgdal)
}

if (!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

if (!require(ggmap)){
  install.packages("ggmap")
  library(ggmap)
}

if (!require(maptools)){
  install.packages("maptools")
  library(mapools)
}

if (!require(rgeos)){
  install.packages("rgeos")
  library(rgeos)
}

if (!require(rgdal)){
  install.packages("rgdal")
  library(rgdal)
}

install.packages("gpclib", type="source")

#Code stolen from:
#https://stackoverflow.com/questions/18016612/r-gradient-plot-on-a-shapefile?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa


# open the shapefile
Eng <- readOGR(dsn = 'G:/EOR3/HCAT/GP Indemnity (restricted)/GP survey (2018)/GPI 2018 Survey analysis/Mapping test/Regions_December_2016_Full_Extent_Boundaries_in_England',
                layer = 'Regions_December_2016_Full_Extent_Boundaries_in_England')

# use the rgn16nm field (representing regions) to create data frame
Eng <- fortify(Eng, region = "rgn16nm")

#need to match up region rows with correct figure, essentially an index match
index <- c('North East', 'North West', 'Yorkshire and The Humber', 'East Midlands', 'West Midlands', 'East of England', 'London', 'South East', 'South West')
values <- as.numeric(c('7972', '7645', '8116', '7948', '8067', '7642', '7194', '8295', '7574'))
Eng$IndemnityCost <- values[match(Eng$id, index)]


# plot
ggplot(Eng, aes(x = long, y = lat, group = group, fill = IndemnityCost)) +
  geom_polygon(colour = "black", size = 0.5, aes(group = group)) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())
