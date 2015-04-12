# Read file and subset data
data <- read.csv2("household_power_consumption.txt", stringsAsFactors=FALSE)
consumption <- subset(data, as.Date(Date, "%d/%m/%Y")>="2007-02-01" & as.Date(Date, "%d/%m/%Y")<="2007-02-02")

# Convert to date-time, remove Date column, rename time column to DateTime
consumption$Time <- strptime(paste(consumption$Date,consumption$Time), "%d/%m/%Y %H:%M:%S")
consumption$Date <- NULL
colnames(consumption)[colnames(consumption)=="Time"] <- "DateTime"

# Set column classes of remaining columns
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
consumption$Voltage <- as.numeric(consumption$Voltage)
consumption$Global_intensity <- as.numeric(consumption$Global_intensity)
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)

# 4. Multiple graphs
# Framework
#dev.new(width=10, height=10)
quartz(width=8,height=8)
par(mfrow = c(2, 2))

# Plot 1
plot(consumption$DateTime, consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 2
plot(consumption$DateTime, consumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot 3
plot(consumption$DateTime, consumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(consumption$DateTime, consumption$Sub_metering_2, col = "red")
lines(consumption$DateTime, consumption$Sub_metering_3, col = "blue")
legend("topright", pch = "-", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4
plot(consumption$DateTime, consumption$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Copy to PNG
dev.copy(png, file = "plot4.png")
dev.off()
