#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
# Get Baltimore FIPS Number
Baltimore_fips <- 24510
# Trim down to just the data for Baltimore that corresponds to ON-ROAD (i.e. vehicles)
#baltimore_data <- (NEI[NEI$fips == Baltimore_fips,]
baltimore_data <- subset(NEI, fips == Baltimore_fips & type == "ON-ROAD")

# Aggregate this data by YEAR
dd <- aggregate(baltimore_data$Emissions, by = list(year = baltimore_data$year), FUN = sum)

# Plotting
png("plot5.png", width=480, height=480, units="px")
plt <- ggplot(dd, aes(x = year, y = x), main = "TEST") + geom_line() + ggtitle("Emissions from Motor Vehicle Sources: Baltimore")

print(plt)
dev.off()