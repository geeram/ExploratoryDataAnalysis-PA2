# Load the required libraries
library(plyr)
library(ggplot2)
library(grid)

## Change working directory & ensure the file "summarySCC_PM25.rds" is there.
## Read the file in to NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Read the Source Classification Code in to SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Filter with regular expression names containing "Coal" or "coal"
NEI2 <- NEI[NEI$SCC %in% SCC[grep("Coal", SCC$EI.Sector), 1], ]
SCC2 <- SCC[, c(1, 4)]
coalClass <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coalClass <- SCC[coalClass, ]
SCC.identifiers <- as.character(coalClass$SCC)

# Select observations relating to coal emissions
NEI$SCC <- as.character(NEI$SCC)
coalNEI <- NEI[NEI$SCC %in% SCC.identifiers, ]
coalTotal <- with(coalNEI, aggregate(Emissions, by = list(year), sum))
colnames(coalTotal) <- c("year", "Emissions")

# Plot to file
png("plot4.png", width = 800, height = 400)
ggplot(data = coalTotal, aes(x = year, y = Emissions)) + geom_line() + geom_point(size=5, shape=21, fill="red") + ggtitle("PM2.5 Emission by Coal Combustion in USA") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

