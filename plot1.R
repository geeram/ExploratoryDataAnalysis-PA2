# Load the required libraries
library(plyr)
library(ggplot2)
library(grid)

## Change working directory & ensure the file "summarySCC_PM25.rds" is there.
## Read the file in to NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Read the Source Classification Code in to SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Total all emissions for the years 1999 to 2008
totalNEI <- tapply(NEI$Emissions, NEI$year, sum)

# Plot output to file
png("plot1.png", width = 480, height = 480)
par(bg = 'grey')
barplot(totalNEI, col = rainbow(10, start = 0, end = 1), xlab = "Year", ylab = "Total PM2.5 Emissions in Tons", main = "Total PM 2.5 Emissions (tons) in USA")
dev.off()

