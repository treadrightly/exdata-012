# Set the working directory to the directory containing Source_Classification_Code.rds and summarySCC_PM25.rds
library(ggplot2)
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore stats
baltimore <- subset(NEI, NEI$fips == "24510")
eSummary <- aggregate(baltimore[,"Emissions"], by=list(baltimore$type, baltimore$year), FUN=sum)
names(eSummary) <- c("type", "year", "emissions")

png(filename="plot3.png", width=480, height=480)
g <- qplot(data=eSummary, x=year, y=emissions, main="Baltimore", xlab="Year", ylab="Emissions") + theme_bw() + facet_wrap(~type, scales="free_y") + geom_smooth(method="lm", se=FALSE)
print(g)
dev.off()