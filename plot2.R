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

# Make global active power a numeric
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))

# Plot Time by Global Active Power, make blank and then add lines
# Open graphics device and close
png(filename="C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 1/plot2.png")
plot(hpc$Time, hpc$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hpc$Time, hpc$Global_active_power)
dev.off()
