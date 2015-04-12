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

# 1. Histogram of global reactive power
quartz(bg = "white")
hist(consumption$Global_active_power, col = "red", main = "Global Reactive Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png")
dev.off()
