#install.packages("sqldf")
library(sqldf)
##Store the data in a sql table(on disk)

##Create/connect to a database named "data_db.sqlite
con <- dbConnect(RSQLite::SQLite(), dbname = "data_db.sqlite")
#Write txt file into the database
dbWriteTable(con, name = "data_table", value = "household_power_consumption.txt", 
             row.names = FALSE, header = TRUE, sep = ";")
#select required dataset
df<- dbGetQuery(con, "SELECT * FROM data_table WHERE Date in ('1/2/2007', '2/2/2007')")

#do some basic exploration on Global_active_power
head(df$Global_active_power)
summary(df$Global_active_power)

#determine the values for the hist
GlobalActivePowerKW <- as.numeric(as.character(df$Global_active_power))

png("plot1.png")
#plot        
hist(GlobalActivePowerKW, col = "red", main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)",
     cex.axis=0.70)

dev.off()

