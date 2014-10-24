# Load the required libraries
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

# Select observations relating to Los Angeles County CA
vehiclesLosAngelesCounty <- NEI[NEI$SCC %in% vehicles$SCC & NEI$fips == "06037",]

# Merge observations of Baltimore and Los Angeles County
vehiclesCompare <- rbind(vehiclesBaltimore, vehiclesLosAngelesCounty)

# Compute yearly totals
vehiclesCompareYearly <- aggregate(Emissions ~ fips * year, data = vehiclesCompare, FUN = sum )

# Assign location names to variable
vehiclesCompareYearly$county <- ifelse(vehiclesCompareYearly$fips == "06037", "Los Angeles", "Baltimore")

# Plot to screen
png("plot6.png", width = 800, height = 480)
qplot(year, Emissions, data = vehiclesCompareYearly, geom = "line", color = county, size = Emissions) + ggtitle("PM2.5 Emissions by Motor Vehicles in Baltimore City, MD, Vs Los Angeles County, CA") + xlab("Year") + ylab("PM2.5 Emissions in Tons")
dev.off()
