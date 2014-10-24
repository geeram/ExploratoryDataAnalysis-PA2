# Load the required libraries
library(plyr)
library(ggplot2)
library(grid)

## Change working directory & ensure the file "summarySCC_PM25.rds" is there.
## Read the file in to NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Read the Source Classification Code in to SCC
SCC <- readRDS("Source_Classification_Code.rds")

# FIlter observations relating to Baltimore MD
Baltimore <- subset(NEI, fips == "24510")

# Total all emissions in Baltimore MD, for the years 1999 to 2008
totalBaltimore <- tapply(Baltimore$Emissions, Baltimore$year, sum)

# Plot to file
png("plot2.png", width = 480, height = 480)
par(bg = 'grey')
barplot(totalBaltimore, col = rainbow(5, start = 0, end = 1), xlab = "Year", ylab = "Total PM2.5 Emissions (Tons)", main = "Yearly Emissions (tons) in Baltimore City, Maryland")
dev.off()

