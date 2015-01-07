library(dplyr)
# Check that the data for this assignment can be loaded into r.
# Roughly the calculation is nrows * ncols * 8 bytes.
# The dataset has 2,075,259 rows and 9 columns, so approximate memory needed is
# 142.5 MB or 0.1425 GB

# Download and the data
data.zip <- "electric.zip"
if(!file.exists(data.zip)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = data.zip)
}

# Read in the data
data <- read.csv(unz(data.zip, "household_power_consumption.txt"), 
                 sep=";",
                 na.strings = "?")

# get the data for the dates 2007-02-01 and 2007-02-01
data <- mutate(data, TempDate = as.Date(data$Date, format = "%d/%m/%Y"))

subdata <- data[data$TempDate == as.Date("2007-02-01") | data$TempDate == as.Date("2007-02-02"),]
subdata <- mutate(subdata, DateTime = paste(subdata$Date, subdata$Time))
subdata$DateTime <- strptime(subdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png",
    width = 480,
    height = 480)
plot(x = subdata$DateTime,
     y = subdata$Global_active_power, 
     type = "n",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
lines(x = subdata$DateTime,
      y = subdata$Global_active_power)
dev.off()
