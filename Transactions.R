library(tidyverse)
library(lubridate)

setwd("C:/Users/ryan_bulger/Documents/R/R Practice Scripts/Hockey/Data/")

lineups <- read.csv("Fantrax-Transaction-History-Lineup Changes-SuperFriends.csv")
add_drop <- read.csv("Fantrax-Transaction-History-Claims+Drops-SuperFriends.csv")

unlink("C:/Users/ryan_bulger/Documents/R/R Practice Scripts/Hockey/Data/*")

lineups <-lineups %>%
    mutate(dates=parse_date_time(Date..MDT.,"mdyIMp",tz="Canada/Mountain"),
           times=hour(dates),
           Position=str_sub(Position,4,4),
           Period=as.integer(Period)) %>%
    select(-c(Date..MDT.,From,To))

add_drop<-add_drop %>%
    mutate(dates=parse_date_time(Date..MDT.,"mdyIMp",tz="Canada/Mountain"),
           times=hour(dates),
           Position=str_sub(Position,4,4),
           Period=as.integer(Period)) %>%
    select(-c(Date..MDT.,Type,Fee))

df <- rbind(lineups,add_drop)

#Time on site
df %>%
    ggplot(aes(times,fill=Team.1)) +
    geom_histogram(bins=24) +
    facet_wrap(~Team.1,nrow=2) +
    xlab("Hour") +
    ylab("Transaction Count") +
    theme(legend.position = "none")

#Transactions by Period
df %>%
    ggplot(aes(Period,fill=Team.1)) +
    geom_bar() +
    facet_wrap(~Team.1,nrow=2) +
    scale_x_continuous(breaks=scales::pretty_breaks()) +
    ylab("Transaction Count") +
    theme(legend.position = "none")
