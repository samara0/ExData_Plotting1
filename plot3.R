
df <- read.table("household_power_consumption.txt",
                 header=TRUE, sep=";", 
                 stringsAsFactors=FALSE)

## check if everything looks okay
dim(df)
str(df)
head(df)

## we see Global_active_power is character variable
## to plot histogram, we need to convert it into numerical 
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)



## extracting smaller data set, df2days, that only
## contains the desired days Feb 1&2 of 2007.
df2days <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

## check if everything is okay
dim(df2days)
str(df2days)

## checking whether there are NA values 
table(is.na(df2days$Sub_metering_1)==T)
table(is.na(df2days$Sub_metering_2)==T)
table(is.na(df2days$Sub_metering_3)==T)

## we see there are no NA values here, for the two days of interest


table(is.na(df2days$Time)==T)

time <- paste0(df2days$Date, " ", df2days$Time)
time <- strptime(time, format="%d/%m/%Y %H:%M:%S")
df2days$Time <- time

str(df2days)

library(png)

## openning png file
png(filename = "plot3.png", width=480, height=480)

with(df2days, plot(Time, Sub_metering_1, type="l",
     xlab="",
     ylab="Energy sub metering"))
with(df2days, lines(Time, Sub_metering_2, type="l",
                   col="red"))
with(df2days, lines(Time, Sub_metering_3, type="l",
                    col="blue"))
legend("topright",lty="solid", col=c("black","red","blue"),
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#closing png file 
dev.off()