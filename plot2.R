
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
head(df$date_time)

#create plot

png("plot2.png")
plot(df$date_time, df$Global_active_power, type="l", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
