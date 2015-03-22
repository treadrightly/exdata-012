# Set the working directory to the directory containing Source_Classification_Code.rds and summarySCC_PM25.rds
library(ggplot2)
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Vehicle emissions are defined as all SCCs with EI.Sector containing "Vehicle"
vehicleSCCs <- SCC[grep("Vehicle", SCC$EI.Sector), "SCC"]

# Baltimore stats
baltimore <- subset(NEI, NEI$fips == "24510")
baltimoreVehicleEmissions <- baltimore[baltimore$SCC %in% vehicleSCCs,]
summary <- aggregate(baltimoreVehicleEmissions[,"Emissions"], by=list(baltimoreVehicleEmissions$year), FUN=sum)
names(summary) <- c("year", "emissions")

png(filename="plot5.png", width=480, height=480)
g <- qplot(data=summary, x=year, y=emissions, main="Coal Combustion", xlab="Year", ylab="Emissions") + geom_smooth(method="lm", se=FALSE) + theme_bw()
print(g)
dev.off()
