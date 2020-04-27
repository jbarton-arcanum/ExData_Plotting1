# Script to generate Plot 4 (plot4.png)


# Check if data exists, then download and unzip it to working directory
if(!file.exists("household_power_consumption.txt")){
        link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(link, destfile = "datadown.zip")
        unzip("datadown.zip")
}

# Read in only the data from Feb 1, 2007 and Feb 2, 2007 and apply column labels
# Range found by guessing and checking
pwrConsumption <- read.table("household_power_consumption.txt",
                             sep = ";", na.strings = "?",
                             skip = 66637, nrows = 2880,
                             stringsAsFactors = F)
names(pwrConsumption) <- names(read.table("household_power_consumption.txt", 
                                          sep = ";", header = T, nrows = 1))

# Combine date and time columns two one column with POSIXlt type
pwrConsumption$datetime <- paste(pwrConsumption$Date, pwrConsumption$Time)
pwrConsumption$datetime <- strptime(pwrConsumption$datetime, format = "%d/%m/%Y %H:%M:%S")

# Saving to png using default 480x480 pixels
png(file = "plot4.png")

# Setup 2x2 plot space
par(mfrow = c(2,2))

# Plot Global Active Power vs Time
with(pwrConsumption, plot(datetime, Global_active_power, type = "l",
                          xlab = NA, ylab = "Global Active Power (kilowatts)"))

# Plot Voltage vs Time
with(pwrConsumption, plot(datetime, Voltage, type = "l",
                          ylab = "Voltage"))

# Plot Sub_metering vs Time
plot(pwrConsumption$datetime, pwrConsumption$Sub_metering_1,
     type = "l", xlab = NA, ylab = "Energy sub metering")
lines(pwrConsumption$datetime, pwrConsumption$Sub_metering_2, type = "l", col = "red")
lines(pwrConsumption$datetime, pwrConsumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.8)

# Plot Global Reactive Power vs Time
with(pwrConsumption, plot(datetime, Global_reactive_power, type = "l"))

dev.off()
