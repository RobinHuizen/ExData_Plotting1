## Loading necessary packages
library(lubridate)

##############################
## Part 1: Loading the data ##
##############################

# Note: when loading the data the sep argument should be set to ";"
hpc <- read.table(file = "household_power_consumption.txt", sep = ";")

# Use the first row to name the columns appropriately
names(hpc) <- hpc[1,]

# Delete the first row as it served its purpose
hpc <- hpc[-1,]

# Check the structure of the data
str(hpc)

# Convert the columns with numeric values to numeric objects
hpc[,3:9] <- data.frame(sapply(hpc[,3:9], as.numeric))

# Convert the 'Date' and 'Time' columns into Date/Time classes
hpc$Date <- dmy(hpc$Date)
hpc$Time <- hms(hpc$Time)

# Subset the data, so we only have the dates 2007-02-01 and 2007-02-02
hpc_subset <- base::subset(hpc, Date == "2007-02-01" | Date == "2007-02-02")

# Look at the data set that we created
summary(hpc_subset)

# Note that there are 0 NA values in this subset
sum(is.na(hpc_subset))

###########################
## Part 2: Making Plots ###
###########################

png("plot1.png")
with(hpc_subset, hist(Global_active_power, 
                      col = "red",
                      main = "Global Active Power",
                      xlab = "Global Active Power (kilowatts)"))
dev.off()

