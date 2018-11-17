library(sqldf)
##Store the data in a sql table(on disk)

##Create/connect to a database named "data_db.sqlite
con <- dbConnect(RSQLite::SQLite(), dbname = "data_db.sqlite")
#Write txt file into the database
dbWriteTable(con, name = "data_table", value = "household_power_consumption.txt", 
             row.names = FALSE, header = TRUE, sep = ";")
#select required dataset
df<- dbGetQuery(con, "SELECT * FROM data_table WHERE Date in ('1/2/2007', '2/2/2007')")

#create a new date_time column for Date Time in POSIXct
df$date_time<- strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
head(df$Sub_metering_1)

png("plot3.png")
plot(df$date_time,df$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
points(df$date_time,df$Sub_metering_2, type="l", col="red")
points(df$date_time,df$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty=1,
       cex=0.8,
       col = c("black","blue","red"))
dev.off()
