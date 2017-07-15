setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 1")

# Separated by ;
# Date and Time are integers, cast to character for later conversion to Date/Time objects
hpc0 <- read.table("household_power_consumption.txt", sep = ";", 
                   header=TRUE, 
                   colClasses = c("Date"="character", "Time"="character"))

# Dates are in D-M-Y format, make 2007-02-01 format
hpc0$Date <- as.Date(hpc0$Date, "%d/%m/%Y")
# Times are in hh:mm:ss format, change to Time object
hpc0$TimeOld <- hpc0$Time
hpc0$Time <- paste(hpc0$Date, hpc0$Time)
hpc0$Time <- strptime(hpc0$Time, format="%Y-%m-%d %H:%M:%S")

# Subset to Feb 1 and 2 of 2007
hpc <- subset(hpc0, Date=="2007-02-02" | Date=="2007-02-01")

# Make variables numeric, first make character
# Make sub meter readings numeric by first casting to a character
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))

# Plot in quadrants using par function
# Includes plots 2 and 4
# Other shows voltage over time
# Other shows inactive power over time

png(filename="C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 1/plot4.png")
par(mfrow=c(2,2)) 

# Top left
plot(hpc$Time, hpc$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hpc$Time, hpc$Global_active_power)

# Top right
plot(hpc$Time, hpc$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(hpc$Time, hpc$Voltage)

# Bottom left
plot(hpc$Time, hpc$Sub_metering_1, col="black", type="n", xlab="", ylab = "Energy sub metering")
lines(hpc$Time, hpc$Sub_metering_1, col="black")
lines(hpc$Time, hpc$Sub_metering_2, col="red")
lines(hpc$Time, hpc$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("black", "red", "blue"), bty="n")

# Bottom right
plot(hpc$Time, hpc$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(hpc$Time, hpc$Global_reactive_power)

dev.off()



