# Set the working directory to the directory containing Source_Classification_Code.rds and summarySCC_PM25.rds

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#keep only Baltimore stats
baltimore <- subset(NEI, NEI$fips == "24510")

years <- unique(baltimore$year)
emissions <- vector()
for (i in 1:length(years))
{
  emissions[i] <- sum(baltimore[baltimore$year == years[i], "Emissions"])
}
png(filename="plot2.png", width=480, height=480)
plot(x=years, y=emissions, xaxt="n", xlab="Year", ylab="Total Emissions", main="Baltimore")
axis(1, at=years)
abline(lm(emissions~years))
dev.off()