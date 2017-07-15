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

# Make sub meter readings numeric by first casting to a character
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))

# Plot all sub meter readings, layer on
# Create a legend for the top right, specifying the names and line colors
# Launch graphics device
png(filename="C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 1/plot3.png")
plot(hpc$Time, hpc$Sub_metering_1, col="black", type="n", xlab="", ylab = "Energy sub metering")
lines(hpc$Time, hpc$Sub_metering_1, col="black")
lines(hpc$Time, hpc$Sub_metering_2, col="red")
lines(hpc$Time, hpc$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("black", "red", "blue"))
dev.off()

