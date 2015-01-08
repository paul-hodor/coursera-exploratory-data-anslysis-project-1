## hpc.all holds the provided household power consumption dataset
##
## hpc is a subset containing only days 2007-02-01 and
## 2007-02-02. Note that the subset does not contain any missing
## values

hpc.all <- read.table(unz("./exdata_data_household_power_consumption.zip",
                          "household_power_consumption.txt"),
                      header=TRUE,sep=";",stringsAsFactors=FALSE)

hpc <- hpc.all[hpc.all$Date %in% c("1/2/2007","2/2/2007"),]



## Make a date/time variable from string representation

hpc$date.time <- strptime(paste(hpc$Date,hpc$Time),format="%d/%m/%Y %H:%M:%S")


## Convert numeric variables from string

vars <- c("Global_active_power","Global_reactive_power","Voltage",
    "Global_intensity","Sub_metering_1","Sub_metering_2")
for (var in vars) {
    hpc[,var] <- as.numeric(hpc[,var])
}


## Make the plots

png("plot4.png",bg="transparent")
op <- par("mfrow","mar")
par(mfrow=c(2,2),mar=c(5.1,4.1,3.1,1.6))

with(hpc,
     plot(date.time,Global_active_power,type="l",
          xlab=NA,ylab="Global Active Power")
     )

with(hpc,
     plot(date.time,Voltage,type="l",
          xlab="datetime")
     )

with(hpc,
     plot(date.time,Sub_metering_1,type="l",
          xlab=NA,ylab="Energy sub metering")
     )
with(hpc,
     lines(date.time,Sub_metering_2,col="red")
     )
with(hpc,
     lines(date.time,Sub_metering_3,col="blue")
     )
legend("topright",bty="n",legend=c("Sub_metering_1","Sub_metering_2",
                      "Sub_metering_3"),lty=1,col=c("black","red","blue"))

with(hpc,
     plot(date.time,Global_reactive_power,type="l",xlab="datetime")
     )

par(mfrow=op)
dev.off()
