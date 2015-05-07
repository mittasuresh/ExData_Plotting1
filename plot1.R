# This is the file for plot1.R

# read the data and convert date and time strings to right format using lubridate library
edata=read.table("household_power_consumption.txt",sep=";",header =TRUE)
head(edata)
str(edata)
library(lubridate)
edata[,1]=dmy(edata[,1])
edata[,2]=hms(edata[,2])
str(edata)

#convert other columns to numeric
for (i in 3:8) edata[,i]=as.numeric(as.character(edata[,i]))
str(edata)

#limit data to the dates of interest and remove original file to freeup memory
subdata=edata[which(edata$Date > "2007-01-31" & edata$Date <= "2007-02-02"),]
rm(edata)

# plot the histogram to the screen
hist(subdata$Global_active_power,xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power",col="red")

# copy plot from screen to a file
dev.print(png,file="plot1.png",height=480,width=480)

# output file plot1.png is created in the working directory
