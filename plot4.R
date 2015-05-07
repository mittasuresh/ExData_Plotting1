# This is the file for plot4.r

# read the data and convert date and time strings to right format using lubridate library
edata=read.table("household_power_consumption.txt",sep=";",header =TRUE)
head(edata)
str(edata)
library(lubridate)
# paste Date and Time into one column and convert it to POSIXct format using lubridate command
edata$datetime=paste(edata$Date,edata$Time)
edata$datetime=dmy_hms(edata$datetime)


#convert other columns to numeric, for some reason column 9 was already a numeric 
for (i in 3:8) edata[,i]=as.numeric(as.character(edata[,i]))
str(edata)

#limit data to the dates of interest, note I used unclass function to get to the integer values of time and date
new_data=edata[which(unclass(edata$datetime) >= unclass(ymd("2007-02-01")) & unclass(edata$datetime)< unclass(ymd("2007-02-03"))),]
str(new_data)

#remove original file to freeup memory
rm(edata)


# initiate the print device, in this case png to create a png file, also give width and height
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#this is plot1 (row1, col1)
plot(new_data$datetime,new_data$Global_active_power,ylab="Global Active Power",xlab="",type="l")


# this is plot # 2 (row1, col 2)
plot(new_data$datetime,new_data$Voltage,ylab="Voltage",xlab="datetime",type="l")


#This is Plot#3 (row2, Col1)

#Plot the first graph, line graph with Y label but no X label
plot(new_data$datetime,new_data$Sub_metering_1,ylab="Energy sub metering",xlab="",type="l")

# Overlay next graph, make sure the Y limit matches the first one, and also turn off axes
# par() functions makes sure we are still working on the earlier plot
par(new=TRUE)
plot(new_data$datetime,new_data$Sub_metering_2,axes=FALSE,ylim=c(0,40),ylab="",xlab="",type="l",col="red")

# Overlay the last one, same as the second with changed variable and color
par(new=TRUE)
plot(new_data$datetime,new_data$Sub_metering_3,axes=FALSE,ylim=c(0,40),ylab="",xlab="",type="l",col="blue")

# Add a legend box on the top right without the bounding box
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),cex=0.9,bty="n",xjust=1)

# this is plot # 4 in the grid
plot(new_data$datetime,new_data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")

#Save plot to to file name plot4.png, turn off the printing device
dev.off()
