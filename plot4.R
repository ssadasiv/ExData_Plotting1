## Exploratory Data Analysis Coursework #1 Plot 4
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

## remove the data read the first time to free memory
rm(CompleteDataSet)

## More conversions
DateTime <- paste(as.Date(MyDataSet$Date), MyDataSet$Time)
MyDataSet$DateTime <- as.POSIXct(DateTime)

## Now plot and save in plot4.png file
par(mfrow=c(2,2),
    mar = c(4,4,2,1),
    oma = c(0,0,2,0))
with(MyDataSet,
     {
       plot(Global_active_power~DateTime,
            type="l",
            ylab = "Global Active Power (kilowatts)",
            xlab="")
       plot(Voltage~DateTime,
            type = "l",
            ylab = "Voltage (volt)",
            xlab = "datetime")
       plot(Sub_metering_1~DateTime,
            type = "l",
            ylab = "Energy sub metering",
            xlab = "")
       lines(Sub_metering_2~DateTime,col='Red')
       lines(Sub_metering_3~DateTime,col='Blue')
       legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
              legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),pch=21, cex=0.5,)
       plot(Global_reactive_power~DateTime, type="l",
            ylab="Global_reactive_power",xlab="datetime")
     })

dev.copy(png,
         file = "plot4.png",
         height = 480,
         width = 480)
dev.off()