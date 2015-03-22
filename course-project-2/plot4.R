# Set the working directory to the directory containing Source_Classification_Code.rds and summarySCC_PM25.rds
library(ggplot2)
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal combustion related emissions are defined as all SCCs with EI.Sector containing "Coal"
coalCombustionSCCs <- SCC[grep("Coal", SCC$EI.Sector), "SCC"]
coalCombustionEmissions <- NEI[NEI$SCC %in% coalCombustionSCCs,]
summary <- aggregate(coalCombustionEmissions[,"Emissions"], by=list(coalCombustionEmissions$year), FUN=sum)
names(summary) <- c("year", "emissions")
png(filename="plot4.png", width=480, height=480)
g <- qplot(data=summary, x=year, y=emissions, main="Coal Combustion", xlab="Year", ylab="Emissions") + theme_bw() + geom_smooth(method="lm", se=FALSE)
print(g)
dev.off()
