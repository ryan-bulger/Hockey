library(tidyverse)
library(rvest)
setwd("C:/Users/ryan_bulger/projects/Hockey")

# Pulls line data from DFO for each team
team <- function (n) {
   tm <<- read_html("https://www.dailyfaceoff.com/teams/") %>%
        html_nodes(".team-list-name") %>%
        html_text() %>%
        tolower() %>%
        gsub(pattern = " ",replacement = "-")
   tm_page <<- str_glue("https://www.dailyfaceoff.com/teams/",{tm[n]},"/line-combinations/")
}

# Pulls line info for a single team from DFO
line_create <- function(node) {
    read_html(tm_page) %>%
        html_nodes(node) %>%
        html_nodes(".player-name") %>%
        html_text
}

# Creates tibble of team lines stacked by: FWD, D, G
lines <- function (n) {
    return({
        read.csv("nodes.csv") %>%
            pmap(line_create)%>%
            unlist() %>%
            tibble(.name_repair=~tm[n]) 
        })
}

# Create blank tibble containing just positions and line numbers
df = tibble(read_csv("positions.csv"))

# Loop through all teams and append to df
#for (i in 1:length(tm)) 
for (i in 11:13) {
    team(i)
    df<-bind_cols(df,lines(i))
}

# Write df to "lines.csv"
write_csv(df,"lines.csv")
#print(df)