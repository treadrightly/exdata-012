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
baltimoreSummary <- aggregate(baltimoreVehicleEmissions[,"Emissions"], by=list(baltimoreVehicleEmissions$year), FUN=sum)
names(baltimoreSummary) <- c("year", "emissions")
# Compute emissions relative to itself, with the value in 1998 used as base. 
# This is because we need to compare baltimore and la stats w.r.t change over time
# and the two cities are not directly comparable in terms of size, population density etc.
# So we use emission values relative to base for graphing
baltimoreSummary$relativeEmissions <- baltimoreSummary$emissions/baltimoreSummary$emissions[1]

# LA stats
la <- subset(NEI, NEI$fips == "06037")
laVehicleEmissions <- la[la$SCC %in% vehicleSCCs,]
laSummary <- aggregate(laVehicleEmissions[,"Emissions"], by=list(laVehicleEmissions$year), FUN=sum)
names(laSummary) <- c("year", "emissions")
# Compute emissions relative to itself, with the value in 1998 used as base. 
# This is because we need to compare baltimore and la stats w.r.t change over time
# and the two cities are not directly comparable in terms of size, population density etc.
# So we use emission values relative to base for graphing
laSummary$relativeEmissions <- laSummary$emissions/laSummary$emissions[1]

baltimoreSummary$city <- "Baltimore"
laSummary$city <- "Los Angeles"

all <- rbind(baltimoreSummary, laSummary)

png("plot6.png", width=480, height=480)
# Using relative emissions on the Y axis - this allows us to see which city shows a bigger change
g <- qplot(data=all, x=year, y=relativeEmissions, main="Motor Vehicle Emissions", xlab="Year", ylab="Emissions relative to 1998") + facet_wrap(~city) + geom_smooth(method="lm", se=FALSE) + theme_bw()
print(g)
dev.off()
