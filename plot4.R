
df <- read.table("household_power_consumption.txt",
                 header=TRUE, sep=";", 
                 stringsAsFactors=FALSE)

## check if everything looks okay
dim(df)
str(df)
head(df)

## converting variables to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Voltage <- as.numeric(df$Voltage)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)



## extracting smaller data set, df2days, that only
## contains the desired days Feb 1&2 of 2007.
df2days <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

## check if everything is okay
dim(df2days)
str(df2days)

## checking whether there are NA values 
table(is.na(df$Global_active_power)==T)
table(is.na(df2days$Time)==T)
table(is.na(df2days$Sub_metering_1)==T)
table(is.na(df2days$Sub_metering_2)==T)
table(is.na(df2days$Sub_metering_3)==T)
table(is.na(df2days$Voltage)==T)
table(is.na(df2days$Global_reactive_power)==T)
## we see there are no NA values here, for the two days of interest



time <- paste0(df2days$Date, " ", df2days$Time)
time <- strptime(time, format="%d/%m/%Y %H:%M:%S")
df2days$Time <- time

str(df2days)

library(png)

## openning png file
png(filename = "plot4.png", width=480, height=480)

par(mfcol=c(2,2))

##plotting (1,1)-plot
with(df2days, plot(Time, Global_active_power, type="l",
          xlab="",
          ylab="Global Active Power (kilowatts)"))

##plotting (2,1)-plot
with(df2days, plot(Time, Sub_metering_1, type="l",
     xlab="",
     ylab="Energy sub metering"))
with(df2days, lines(Time, Sub_metering_2, type="l",
                   col="red"))
with(df2days, lines(Time, Sub_metering_3, type="l",
                    col="blue"))
legend("topright", box.lty=0, lty="solid", col=c("black","red","blue"),
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##plotting (1,2)-plot, i.e. upper right plot
with(df2days, plot(Time, Voltage, type="l",
                   xlab = "daytime",
                   ylab = "Voltage"))

## plotting (2,2)-plot, i.e. down right plot
with(df2days, plot(Time, Global_reactive_power, type="l",
                   xlab = "daytime",
                   ylab = "Global_reactive_power"))


#closing png file 
dev.off()