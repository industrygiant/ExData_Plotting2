library("ggplot2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# From the Levels of SCC$EI.Sector we know that levels 13, 18 and 23 correspond to Coal combustion.
# Let's grab the full names of these levels and then subset the data using them
coal_comb <- levels(SCC$EI.Sector)[c(13,18,23)]
df2 <- SCC[SCC$EI.Sector %in% coal_comb, ]
# Grab the SCC identifiers which we will use in the NEI data set to grab only coal related sources
scc_identifiers <- df2$SCC

# Trim down the NEI database using these SCC Identifiers
trimmed_df <- (NEI[NEI$SCC %in% scc_identifiers,])

# Make 2 separate data frames for all coal emissions separated by TYPE and another for TOTAL coal emissions
df <- aggregate(trimmed_df$Emissions, by = list(type = trimmed_df$type, year = trimmed_df$year), FUN = sum)
total <- aggregate(trimmed_df$Emissions, by = list(year = trimmed_df$year), FUN = sum)



#Now make the plots
png("plot4.png", width=960, height=480, units="px")
plt1 <- ggplot(df, aes(x = year, y = x, colour = type)) + geom_smooth(method = "loess")
plt2 <- ggplot(total, aes(x = year, y = x), main = "TEST") + geom_line()

plt1 <- plt1 + ggtitle("US emissions from coal combustion by TYPE")
plt2 <- plt2 +  ggtitle("TOTAL US emissions from coal combustion")
require(gridExtra)
# Uses a plotting library to put both plots on one PNG file
print(grid.arrange(plt1,plt2,ncol=2))
dev.off()