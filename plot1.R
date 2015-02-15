## This first line will likely take a few seconds. Be patient!
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# First get the different YEARS we can consider
years <- unique(NEI$year)

#Load plotting libraries
library("lattice")
library("graphics")

png("plot1.png", width=480, height=480, units="px")

ydata = c()

for (y in years){
  ydata <- c(ydata,((sum( NEI[NEI$year == y ,]$Emissions ))))
}
plot(years,ydata, type = "l", xlab = "Year", ylab = "Total Emissions", main = "Total PM2.5 emission from all sources 1999 - 2008")
dev.off()