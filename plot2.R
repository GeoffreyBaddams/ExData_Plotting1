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

par(mfrow=c(1,1))
plot(x=EPC$DateTime,y=EPC$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file = "plot2.png")
dev.off()