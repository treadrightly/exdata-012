# Set the working directory to the directory containing Source_Classification_Code.rds and summarySCC_PM25.rds

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- unique(NEI$year)
emissions <- vector()
for (i in 1:length(years))
{
  emissions[i] <- sum(NEI[NEI$year == years[i], "Emissions"])
}
png(filename="plot1.png", width=480, height=480)
plot(x=years, y=emissions, xaxt="n", xlab="Year", ylab="Total Emissions")
axis(1, at=years)
abline(lm(emissions~years), col="green")
dev.off()
