#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
Baltimore_fips <- "24510"
LA_fips <- "06037"

# Get motor vehicle emissions for both data sets
both  <- subset(NEI, (fips == LA_fips | fips == Baltimore_fips) & type == "ON-ROAD")

df <- aggregate(both$Emissions, by = list(city = both$fips, year = both$year), FUN = sum)
# Change FIPS value to the actual city name
df$city[df$city == "06037"] <- "LA"
df$city[df$city == "24510"] <- "Baltimore"

png("plot6.png", width=480, height=480, units="px")
plt <- ggplot(df, aes(x = year, y = x, colour = city)) + geom_smooth(method = "loess")+ ggtitle("Comparison of Motor Vehicle Emissions: LA and Baltimore")

print(plt)
dev.off()