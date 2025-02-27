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


#plot PNG Graph with a width of 480 X 480 pixels.
png(filename="./Week1/plot1.png", width = 480, height = 480,units = "px")
#Plot1
plot(hist(epc$Global_active_power),col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatt)",cex.axis=0.5)
dev.off()


