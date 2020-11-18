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
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)

#Plot 1 
hist(EPC$Global_active_power,col="red",main="Global Active Power",xlab = "Global Active Power (kilowatts)")
#Saving file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

#Plot 2
#create DateTime column
EPC$DateTime <-paste(EPC$Date,EPC$Time)
EPC$DateTime <- as.POSIXct(EPC$DateTime)
plot(EPC$Global_active_power~EPC$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
#Saving file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#Plot 3 

with(EPC, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Saving file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

#4  
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(EPC, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#Saving file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()