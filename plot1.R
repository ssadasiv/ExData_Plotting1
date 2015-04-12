## Exploratory Data Analysis Coursework #1 Plot 1
## This script uses the electric power consumption in one household over a 4 year period
## The dataset has 2,075,259 rows and 9 columns
##
## For the purposes of this coursework only the data for February 1 and 2 of year 2007 will be considered.

## Read, clean and subset the data for this assignment- note the data file should coexist with this script.
NumRows = 2075259
CompleteDataSet <- read.csv("household_power_consumption.txt", 
                            header=TRUE, 
                            na.strings="?",
                            sep=";",
                            nrows=NumRows,
                            quote='\"',
                            check.names=FALSE, 
                            stringsAsFactors=FALSE,
                            comment.char="")
## Change the format we want to use
CompleteDataSet$Date <-as.Date(CompleteDataSet$Date, format="%d/%m/%Y")

## Now Subset the data for the dates we need.
MyDataSet <- subset(CompleteDataSet, subset=(Date>= "2007-02-01" & Date<= "2007-02-02"))

# remove the data read the first time to free memory
rm(CompleteDataSet)

## More conversions
DateTime <- paste(as.Date(MyDataSet$Date), MyDataSet$Time)
MyDataSet$DateTime <- as.POSIXct(DateTime)

## Now plot and save in plot1.png file
hist(MyDataSet$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "Red")

dev.copy(png,
         file = "plot1.png",
         height = 480,
         width = 480)
dev.off()