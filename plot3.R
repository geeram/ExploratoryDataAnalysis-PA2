# Load the required libraries
library(plyr)
library(ggplot2)
library(grid)

## Change working directory & ensure the file "summarySCC_PM25.rds" is there.
## Read the file in to NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Read the Source Classification Code in to SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Filter observations relating to Baltimore MD
Baltimore <- subset(NEI, fips == "24510")

# Total all emissions in Baltimore for the years 1999 to 2008
typeBaltimore <- ddply(Baltimore, .(year, type), function(x) sum(x$Emissions))

# Rename the column which was modified by R
colnames(typeBaltimore)[3] <- "emissions"

# Plot to file
png("plot3.png", width = 580, height = 480)
par(bg = 'grey')
qplot(year, emissions, data = typeBaltimore, color = type, geom = "line") + ggtitle("PM2.5 Emission by Type and Year in Baltimore City") + xlab("Year") + ylab("Total PM2.5 Emissions in tons") + theme(legend.position = c(0.9, 0.85))
dev.off()
