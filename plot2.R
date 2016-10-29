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
#Create new DateTime column by combining date and time columns oin data frame
filteredData$DateTime <- as.POSIXct(paste(filteredData$Date, as.character(filteredData$Time)))
#Draw the historgram
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(filteredData, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
#Save as .png file
dev.off()