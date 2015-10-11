library(sqldf)
library(datasets)

#Download File
#setwd("/Users/xxx/Desktop/R Work/Exploratory_data_analysis")
if(!file.exists("./Week1")){dir.create("./Week1")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileurl,destfile="./Week1/epc.zip",method="curl")
## Unzip file
unzip("./Week1/epc.zip",exdir ="./Week1/")

# conditional loading of data with sqldf's select 
epc1 <- read.csv.sql("./Week1/household_power_consumption.txt", sep = ";" ,"select * from file where Date in ('1/2/2007','2/2/2007')")
dt <- strptime(paste(epc1$Date,epc1$Time), "%d/%m/%Y %H:%M:%S")
#dt
epc <- cbind(dt,epc1)
names(epc)[1] <- "datetime"

#head(epc)

#plot PNG graph of 480 x 480 - 2 Rows x 2 columns
png(filename="./Week1/plot4.png", width = 480, height = 480,units = "px")
###### Plot4 #####
par(mfcol = c(2,2))

#Plot1
plot(epc$datetime,epc$Global_active_power,type = "l",ylab = "Global Active Power (kilowatt)",xlab = "", cex.axis=0.5)

#Plot2
plot(epc$datetime,epc$Sub_metering_1,type = "l",ylab = "Global Active Power (kilowatt)",xlab = "", cex.axis=0.5)
lines(epc$datetime,epc$Sub_metering_2, col = "red")
lines(epc$datetime,epc$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1) , col=c("black","red","blue"), bty = "n" )

#Plot3
plot(epc$datetime,epc$Voltage,type = "l",ylab = "Voltage",xlab = "datetime", cex.axis=0.5)

# Global Reactive Power
plot(epc$datetime,epc$Global_reactive_power,type = "l",ylab = "Global Reactive Power",xlab = "datetime", cex.axis=0.5)

dev.off()


