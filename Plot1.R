# Author: Surya Gurung
# Plot1.R
######################
# This scripts does the following tasks:
# 1. Sets the working directory and downloads the dataset zip file to the directory from given url
#    and extract it if the file is not already downloaded extracted.  
# 2. Read text file and extract the specified rows.
# 3. Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels

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
hpcSubset[ , 'Global_active_power'] <- as.numeric(hpcSubset$Global_active_power)

# constructing histogram and saving it in png file
png('plot1.png', width = 480, height = 480)
with(hpcSubset, hist(Global_active_power, col = 'red', main = 'Global Active Power',
                                xlab = 'Global Active Power (kilowatts)'))
dev.off()

