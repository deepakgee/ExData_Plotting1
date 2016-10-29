destFile <- "./data/household_power_consumption.txt"
#Download the file only if it's not already downloaded
if(!file.exists(destFile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
        unzip("data.zip", exdir="data")
}
data <- read.csv(destFile, sep = ";", header=TRUE, stringsAsFactors = FALSE)
#Convert date column to actual Date type
data[,1] <- as.Date(data[,1], "%d/%m/%Y")
#Filter down to the dataset for the relevant dates only
filteredData <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
#Convert data type to numeric for Global active power column
filteredData$Global_active_power <- as.numeric(as.character(filteredData$Global_active_power))
filteredData$Sub_metering_1 <- as.numeric(as.character(filteredData$Sub_metering_1))
filteredData$Sub_metering_2 <- as.numeric(as.character(filteredData$Sub_metering_2))
filteredData$Sub_metering_3 <- as.numeric(as.character(filteredData$Sub_metering_3))
filteredData$Voltage <- as.numeric(as.character(filteredData$Voltage))
filteredData$Global_reactive_power <- as.numeric(as.character(filteredData$Global_reactive_power))
#Create new DateTime column by combining date and time columns oin data frame
filteredData$DateTime <- as.POSIXct(paste(filteredData$Date, as.character(filteredData$Time)))
#Setup drawing area in 2 by 2
png(filename = "plot4.png", width = 480, height = 480, units = "px")
pardefault <- par(mfcol = c(2,2))
pardefault
#Draw first plot - Global Active power
with(filteredData, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))
#Draw second plot
with(filteredData, plot(DateTime, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
par(new = FALSE)
with(filteredData, lines(DateTime, Sub_metering_1, type = "l", col = "black"))
with(filteredData, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(filteredData, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend( x = "topright", pch=c(NA,NA, NA), col=c("black", "red", "blue"), lwd = 1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n")
pardefault
#Draw 3rd plot
with(filteredData, plot(DateTime, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))
#Draw 4th plot
with(filteredData, plot(DateTime, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))
#Save as .png file
dev.off()