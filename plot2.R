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


## Make the plot

png("plot2.png",bg="transparent")
with(hpc,
     plot(date.time,Global_active_power,type="l",
          xlab=NA,ylab="Global Active Power (kilowatts)")
     )
dev.off()
