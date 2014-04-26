trips = read.csv("/Users/xinh/Downloads/201402-babs-open-data/201402_trip_data.csv")

###
### TRIP LENGTH ###
###

#median trip length is 9 min.
summary(trips)

#total trips: 144015
#short trups: 138319 (96%)
short_trips=subset(trips, Duration<3600)
nrow(trips)
nrow(short_trips)

#histogram of short trips
hist(short_trips$Duration, main="Trip Length Distribution", xlab="trip length
(sec.)", col="blue")

#long trips: 5696
long_trips=subset(trips,Duration>=3600)
summary(long_trips)
#majority are (short-term) customers: 5379/5696 (94%)
#avg. length: 15982 s. (4.5 hr, $49 in late fees)
#total late fees: 5696 * $49 = $280k

###
### POPULAR STATIONS ###
###

summary(trips$Start.Station)
# top 3 start stations
# San Francisco Caltrain (Townsend at 4th)     :  9838
# Harry Bridges Plaza (Ferry Building)         :  7343
# Embarcadero at Sansome                       :  6545

customer_trips=subset(trips,Subscription.Type=="Customer")
subscriber_trips=subset(trips,Subscription.Type=="Subscriber")

summary(customer_trips)
#most popular start station among customers: Embarcadero at Sansome
summary(subscriber_trips)
#most popular start station among subscribers: San Francisco Caltrain (Townsend at 4th)

###
### DAY OF WEEK OF TRIPS ###
###

library(chron)
#customer trips
char_date_cust=c(as.character(customer_trips$Start.Date))
date_cust<-as.chron(VAR,"%m/%d/%Y %H:%M")
# day of week
dwkn_cust <- as.numeric(format(date_cust , "%w"))
hist(dwkn_cust, breaks=-.5+0:7, labels=c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"),
+ main="Customer Trips", xlab="day of week", ylim=c(0,7000), col="purple")

#subscriber trips
char_date_sub=c(as.character(subscriber_trips$Start.Date))
date_sub<-as.chron(char_date_sub,"%m/%d/%Y %H:%M")
# day of week
dwkn_sub <- as.numeric(format(date_sub , "%w"))
hist(dwkn_sub, breaks=-.5+0:7, labels=c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"),
main="Subscriber Trips", xlab="day of week", ylim=c(0,25000), col="green")
