## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2
library("ggplot2")
# Get Baltimore FIPS Number
Baltimore_fips <- 24510
# Trim down to just the data for Baltimore
baltimore_data <- NEI[NEI$fips == Baltimore_fips,]
# Make a data frame, splitting the emissions data into subsets
# of TYPE and YEAR and computing the sum over these subsets
df <- aggregate(baltimore_data$Emissions, by = list(type = baltimore_data$type, year = baltimore_data$year), FUN = sum)

# time to plot this data
png("plot3.png", width=480, height=480, units="px")
plt <- ggplot(df, aes(x = year, y = x, colour = type)) + geom_smooth(method = "loess")
print(plt)
dev.off()

dev.off()