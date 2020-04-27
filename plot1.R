# Script to generate Plot 1 (plot1.png)


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

# Plot and label histogram of Global Active Power
# Saving to png using default 480x480 pixels
png(file = "plot1.png")
with(pwrConsumption, hist(Global_active_power, col = "red", 
                          main = "Global Active Power", 
                          xlab = "Global Active Power (kilowatts)"))
dev.off()
