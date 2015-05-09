#extracting data frame names
EPCnames=names(read.table("household_power_consumption.txt",header=TRUE,sep=";",nrows=1))

#first date index minus last date index (numbers obtained via inspecting data set)
relevantRows = 69516-66636

#reading in Electric Power Consumption data and assigning names obtained in line 1
EPC <- read.table("household_power_consumption.txt",header=TRUE,sep=";",
                  skip=66636,nrows=relevantRows,col.names=EPCnames,na.strings="?") 

#replacing date and time in POSIX format
DateTime <- strptime(paste(EPC$Date,EPC$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")
EPC <- data.frame(DateTime, EPC[,3:9])

par(mfrow = c(2,2))

hist(EPC$Global_active_power,main="Global Active Power",xlab="Global Active Power",col=2)

plot(x=EPC$DateTime,y=EPC$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

plot(x=EPC$DateTime,y=EPC$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
points(x=EPC$DateTime,y=EPC$Sub_metering_1,type="l",col=1)
points(x=EPC$DateTime,y=EPC$Sub_metering_2,type="l",col=2)
points(x=EPC$DateTime,y=EPC$Sub_metering_3,type="l",col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c(1,2,4))

plot(EPC$DateTime,EPC$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.copy(png,file = "plot4.png")
dev.off()