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

if (!require(gpclib)){
  install.packages("gpclib")
  library(gpclib)
}
#install.packages("gpclib", type="source")

#Code stolen from:
#https://stackoverflow.com/questions/18016612/r-gradient-plot-on-a-shapefile?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
#shapefile available here:
#https://data.gov.uk/dataset/39ebefcc-0484-4e38-981a-29dc6d4b404a/regions-december-2016-full-extent-boundaries-in-england

# open the shapefile
Eng <- readOGR(dsn = 'path/Regions_December_2016_Full_Extent_Boundaries_in_England',
                layer = 'Regions_December_2016_Full_Extent_Boundaries_in_England')

# use the rgn16nm field (representing regions) to create data frame
Eng <- fortify(Eng, region = "rgn16nm")

#need to match up region rows with correct figure, essentially an index match
index <- c('North East', 'North West', 'Yorkshire and The Humber', 'East Midlands', 'West Midlands', 'East of England', 'London', 'South East', 'South West')
values <- as.numeric(c('4500', '9000', '7000', '4000', '5500', '2000', '6000', '7000', '7000'))
Eng$Cost <- values[match(Eng$id, index)]


p <- ggplot(Eng, aes(x = long, y = lat, group = group, fill = Cost)) + 
  geom_polygon(colour = "black", size = 0.5, aes(group = group)) + # border colour
  scale_fill_gradient(low = "snow1", high = "springgreen3") + # colour gradient automatically generated for values
  theme(axis.line=element_blank(),axis.text.x=element_blank(), #rest of this gets rid of axes which aren't needed for maps 
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())



plot(p) 


