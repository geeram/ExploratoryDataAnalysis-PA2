# Load required libraries
library(plyr)
library(ggplot2)
library(grid)

## Change working directory & ensure the file "summarySCC_PM25.rds" is there.
## Read the file in to NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Read the Source Classification Code in to SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Filter with regular expression names containing "Vehicles" or "vehicles"
vehicles1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
vehicles <- SCC[SCC$EI.Sector %in% vehicles1, ]["SCC"]

# Select observations relating to Baltimore MD
vehiclesBaltimore <- NEI[NEI$SCC %in% vehicles$SCC & NEI$fips == "24510",]

# Compute yearly totals
vehiclesBaltimoreYearly <- ddply(vehiclesBaltimore, .(year), function(x) sum(x$Emissions))

# Rename columns meaningfully
colnames(vehiclesBaltimoreYearly)[2] <- "emissions"

# Plot to screen
png("plot5.png", width = 480, height = 480)
qplot(year, emissions, data = vehiclesBaltimoreYearly, geom = "line", color = emissions, size = 1) + ggtitle("PM2.5 Emissions by Motor Vehicles in Baltimore City") + xlab("Year") + ylab("PM2.5 Emissions in Tons")
dev.off()

