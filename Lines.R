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

df = tibble(read_csv("positions.csv"))

#for (i in 1:length(tm)) 
for (i in 11:13) {
    team(i)
    df<-bind_cols(df,lines(i))
}
#print(df)
write_csv(df,"lines.csv")
#INJURIES
    #tryCatch(lines[[8]],error=function(e) NA)
    # Pull injury type ("IR", "DTD", "OUT")
    # Sorted by Position (from NHL API)

# FULL TEAM TABLE
    # Used to display full team for visualization
    # 3 x 7 matrix
    # No col headers
    # F on top, D lines below and split L & R w/ G in between D