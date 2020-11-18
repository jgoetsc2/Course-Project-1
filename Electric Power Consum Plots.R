library(httr)
library(dplyr)
# filename <- "EPC.txt"
# url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# f <- file.path(getwd(), filename)
# download.file(url, f)
# unzip(filename) 
EPC <- read.table('household_power_consumption.txt',header = TRUE,sep = ";",na.strings = "?")
#Foramt date to Type date
EPC$Date <- as.Date(EPC$Date,"%d/%m/%Y")
head(EPC)#filter data from 2/1/2007 to 2/2/2007
EPC <- EPC %>% filter(Date >= as.Date("2007-2-1") & Date<= as.Date("2007-2-2"))
head(EPC)
EPC$Global_active_power <- as.numeric(EPC$Global_active_power)
EPC$Global_reactive_power <- as.numeric(EPC$Global_reactive_power)
voltage <- as.numeric(EPC$Voltage)
subMetering1 <- as.numeric(EPC$Sub_metering_1)
subMetering2 <- as.numeric(EPC$Sub_metering_2)
subMetering3 <- as.numeric(EPC$Sub_metering_3)

#Plot one Histogram 
hist(EPC$Global_active_power,col="red",main="Global Active Power",xlab = "Global Active Power (kilowatts)")
