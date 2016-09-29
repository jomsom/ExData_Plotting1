# Author: Surya Gurung
# Plot4.R
######################
# This scripts does the following tasks:
# 1. Sets the working directory and downloads the dataset zip file to the directory from given url
#    and extract it if the file is not already downloaded extracted.  
# 2. Read text file and extract the specified rows.
# 3. Construct the plots and save it to a PNG file with a width of 480 pixels and a height of 480 pixels

#########################################################################################################
#sets working directory and file name
setwd('C:/Users/mars/Documents/rprojects') 
fName <- 'household_power_consumption.zip'

# if the data is not downloaded yet, loads the dataset from given url.
if (!file.exists(fName)){
    fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(fileURL, destfile = fName, method='curl')
}  

# unzip the downloaded data set file if it hasn't done yet.
if (!file.exists('household_power_consumption.txt')) { 
    unzip(fName) 
}

# Reading 'household_power_consumption.txt' file and extract specified rows
hpcData <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', stringsAsFactors=FALSE, dec=".")
hpcSubset <- hpcData[hpcData$Date %in% c( '1/2/2007', '2/2/2007'), ]

# Converting sub_metering_1, sub_metering_2, sub_metering_3, Global_active_power, Voltage, and
# Global_reactive_power variables to numeric 
subMetering1 <- as.numeric(hpcSubset$Sub_metering_1)
subMetering2 <- as.numeric(hpcSubset$Sub_metering_2)
subMetering3 <- as.numeric(hpcSubset$Sub_metering_3)
globalActivePower <- as.numeric(hpcSubset$Global_active_power)
Global_reactive_power <- as.numeric(hpcSubset$Global_reactive_power)
Voltage <- as.numeric(hpcSubset$Voltage)

# Concatenating and converting Date and Time variable to POSIXlt class
datetime <- strptime(paste(hpcSubset$Date, hpcSubset$Time), format = '%d/%m/%Y %H:%M:%S')

# constructing two columns of two plots and saving it in png file
png('plot4.png', width = 480, height = 480)
par(mfcol = c(2,2))

plot(datetime, globalActivePower, col = 'black', ylab = 'Global Active Power', xlab = '', type = "l")
plot(datetime, subMetering1, col = 'black', ylab = 'Energy Sub Metering', xlab = '', type = "l")
lines(datetime, subMetering2, col = 'red', type = 'l')
lines(datetime, subMetering3, col = 'blue', type = 'l')
legend('topright', lty = 1, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_meteting_3'), col = c('black','red', 'blue'))

plot(datetime, Voltage, type =  'l')
plot(datetime, Global_reactive_power, type = 'l')
dev.off()

