# This is the file for plot2.R

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

# plot line graph with Global ACtive Power on Y axis and datetime on X axis, with appropriate titles
# graph is plotted on the screen
plot(new_data$datetime,new_data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")

#Save plot to to file name plot2.png
dev.print(png,file="plot2.png",height=480,width=480)
