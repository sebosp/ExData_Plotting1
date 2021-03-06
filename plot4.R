if (!file.exists("household_power_consumption.txt")){
	print("household_power_consumption.txt does not exist.")
	print("please follow the instructions from the course.")
	print("get the zip and uncompress it in this directory ")
	stopifnot(file.exists("household_power_consumption.txt"))
}
data <- read.delim(pipe('grep -E "^[12]/2/2007" household_power_consumption.txt'),header=FALSE,sep=";",na.strings=c('?'))
names(data) <- c(
		 'Date' # Date in format dd/mm/yyyy
		,'Time' # time in format hh:mm:ss
		,'Global_active_power' # household global minute-averaged active power (in kilowatt)
		,'Global_reactive_power' # household global minute-averaged reactive power (in kilowatt)
		,'Voltage' # minute-averaged voltage (in volt)
		,'Global_intensity' # household global minute-averaged current intensity (in ampere)
		,'Sub_metering_1' # energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
		,'Sub_metering_2' # energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
		,'Sub_metering_3' # energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
		 )
data$dateTime <- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))
# top left plot, same as plot2
plot(data$dateTime,data$Global_active_power,type="l",ylab="Global Active Power",xlab="")
# Bottom left plot, same as plot3
plot(data$dateTime,data$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(data$dateTime,data$Sub_metering_1,type="l",col="black")
lines(data$dateTime,data$Sub_metering_2,type="l",col="red")
lines(data$dateTime,data$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),lty=1,legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),bty="n")
# top right plot, voltage
plot(data$dateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime")
# top right plot, global reactive power
plot(data$dateTime,data$Global_reactive_power,type="l",ylab="Global_Reactive_Power",xlab="datetime")
dev.off()
print("File plot4.png should be available now")


