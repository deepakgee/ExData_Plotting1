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
#Draw the historgram
hist(as.numeric(as.character(filteredData$Global_active_power)), xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
#Save as .png file
dev.copy(png, "plot1.png")
dev.off()