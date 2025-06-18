## Loading necessary packages
library(lubridate)
library(dplyr)

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

# Convert the columns with numeric objects
hpc[,3:9] <- data.frame(sapply(hpc[,3:9], as.numeric))

# Combine Date and Time by creating a DateTime column
hpc <- hpc %>% mutate(DateTime = dmy_hms(paste(Date, Time)), .before = 1)

# Delete the redundant Date and Time columns
hpc <- hpc[,-c(2,3)]

# Subset the data, so we only have the dates 2007-02-01 and 2007-02-02
hpc_subset <- base::subset(hpc, as.Date(DateTime) %in% c("2007-02-01", "2007-02-02"))

# Look at the data set that we created
summary(hpc_subset)

# Note that there are 0 NA values in this subset
sum(is.na(hpc_subset))

###########################
## Part 2: Making Plots ###
###########################

png("plot4.png")

par(mfcol = c(2,2), mar = c(3,4,3,1))

# Top left plot (Plot2.png)
with(hpc_subset, plot(DateTime, 
                      Global_active_power, 
                      type = "n", 
                      xlab = "",
                      ylab = "Global Active Power",
                      xaxt = "n"
))
with(hpc_subset, axis(1, at = as.numeric(as.POSIXct(c("2007-02-01 00:00:00", 
                                                      "2007-02-02 00:00:00", 
                                                      "2007-02-02 23:59:00"))),
                      labels = c("Thu", "Fri", "Sat")))
with(hpc_subset, lines(DateTime, Global_active_power))

# Bottom left plot (Plot3.png)
with(hpc_subset, plot(DateTime, Sub_metering_1,
                      type = "n",
                      xaxt = "n",
                      xlab = "",
                      ylab = "Energy Sub Metering"))
with(hpc_subset, lines(DateTime, Sub_metering_1))
with(hpc_subset, lines(DateTime, Sub_metering_2, col = "red"))
with(hpc_subset, lines(DateTime, Sub_metering_3, col = "blue"))     
with(hpc_subset, legend("topright", col = c("black", "red", "blue"), 
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                        lty = c(1,1), cex = 0.8))
with(hpc_subset, axis(1, at = as.numeric(as.POSIXct(c("2007-02-01 00:00:00", 
                                                      "2007-02-02 00:00:00", 
                                                      "2007-02-02 23:59:00"))),
                      labels = c("Thu", "Fri", "Sat")))


# Top right hand plot
with(hpc_subset, plot(DateTime, 
                      Voltage, 
                      type = "n", 
                      xlab = "",
                      ylab = "Voltage",
                      xaxt = "n"
))
with(hpc_subset, axis(1, at = as.numeric(as.POSIXct(c("2007-02-01 00:00:00", 
                                                      "2007-02-02 00:00:00", 
                                                      "2007-02-02 23:59:00"))),
                      labels = c("Thu", "Fri", "Sat")))
with(hpc_subset, lines(DateTime, Voltage))

# Bottom right hand plot
with(hpc_subset, plot(DateTime, 
                      Global_reactive_power, 
                      type = "n", 
                      xlab = "",
                      ylab = "Global Reactive Power",
                      xaxt = "n"
))
with(hpc_subset, axis(1, at = as.numeric(as.POSIXct(c("2007-02-01 00:00:00", 
                                                      "2007-02-02 00:00:00", 
                                                      "2007-02-02 23:59:00"))),
                      labels = c("Thu", "Fri", "Sat")))
with(hpc_subset, lines(DateTime, Global_reactive_power))
dev.off()
