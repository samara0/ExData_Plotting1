
df <- read.table("household_power_consumption.txt",
                 header=TRUE, sep=";", 
                 stringsAsFactors=FALSE)

## check if everything looks okay
dim(df)
str(df)

## we see Global_active_power is character variable
## to plot histogram, we need to convert it into numerical 
df$Global_active_power <- as.numeric(df$Global_active_power)

table(is.na(df$Global_active_power)==T)

## there are 25979 NA values in the vector df$Global_active_power


## extracting smaller data set, df2days, that only
## contains the desired days Feb 1&2 of 2007.
df2days <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

## check if everything is okay
dim(df2days)
str(df2days)

## checking whether there are NA values (in the initial data frame)
## there were 25979 missing Global_active_power values)
table(is.na(df2days$Global_active_power))

## we see there are no NA values here, for the two days of interest


#plot histogram with breaks from 0 - 7.5

table(is.na(df2days$Time)==T)

time <- paste0(df2days$Date, " ", df2days$Time)
time <- strptime(time, format="%d/%m/%Y %H:%M:%S")

str(df2days)

library(png)

## openning png file
png(filename = "plot2.png", width=480, height=480)

plot(time, df2days$Global_active_power, type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

#closing png file 
dev.off()