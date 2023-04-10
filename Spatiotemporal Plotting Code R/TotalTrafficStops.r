
rm(list = ls())

library(ggplot2)
library(ggmap) # for plotting maps
library(RColorBrewer)

register_google(key = "notrealkey_enteryourown", write = TRUE)

## See http://www.thebureauinvestigates.com/2014/05/23/get-the-data-what-the-drones-strike/

drone.data <- read.csv(file="TotalTrafficStops.csv")
## Break down by year
month <- vector()
for(i in 1:nrow(drone.data)) {
  dateStr <- toString(drone.data$Date[i])
  dateStrSplit <- strsplit(dateStr, "-")[[1]]
  month[i] <- as.numeric(dateStrSplit[2])
}
drone.data$month <- month
## Subset the data by month
subset.drone.data <- subset(drone.data, month >= 0)
## Convert month to factor
subset.drone.data$month <- as.factor(subset.drone.data$month)

## Specify a map with center at the center of all the coordinates
mean.longitude <- mean(subset.drone.data$Longitude)
mean.latitude <- mean(subset.drone.data$Latitude)
drone.map <- get_map(location = c(mean.longitude, mean.latitude),
                     zoom = 11, scale = 2)
drone.map <- ggmap(drone.map, extent="device", legend="none")
## Plot a heat map layer: Polygons with fill color based on relative frequency of events
drone.map <- drone.map + stat_density2d(data=subset.drone.data,
                                        aes(x=Longitude, y=Latitude, fill=..level..,
                                            alpha=..level..), geom="polygon")
## Define the colors to fill the density contours
drone.map <- drone.map + scale_fill_gradientn(colours=rev(brewer.pal(9, "YlOrRd")))

## Remove any legend
drone.map <- drone.map + guides(size=FALSE, alpha = FALSE)
## Give the map a title
## drone.map <- drone.map + ggtitle("TotalTrafficStops")

## Plot strikes by each year
drone.map <- drone.map + facet_wrap(~month) + theme_bw()
print(drone.map)
## Save the plot on disk
ggsave(filename="TotalTrafficStops.png")
