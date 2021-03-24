library(tidyverse)
library(rvest)

# TEAM NAMES FUNCTION
team <- function (n) {
   tm <- read_html("https://www.dailyfaceoff.com/teams/") %>%
        html_nodes(".team-list-name") %>%
        html_text() %>%
        tolower() %>%
        gsub(pattern = " ",replacement = "-")
   url <<- str_glue("https://www.dailyfaceoff.com/teams/",{tm[n]},"/line-combinations/")
}
    
team(9)
url

team <- teams[10]

# LINES FUNCTION
    # Takes in team URL name
    # TABLES:
        # Tables func takes in line node & col names
line_create <- function(node,n) {
    read_html(url) %>%
        html_nodes(node) %>%
        html_nodes(".player-name") %>%
        html_text %>%
        matrix(n) %>%
        t() %>%
        as_tibble()
}
read_csv("line-nodes.csv")

nodes_list <- tribble(~node,~n,
        "#forwards",3,
        "#defense",2,
        "#pp-forwards-container",3,
        "#pp-defense-container",2,
        "#pp2-forwards-container",3,
        "#pp2-defense-container",2,
        "#goalies-container",1,
        "#ir-container",1)

lines <- nodes_list %>%
    pmap(line_create)

FWD <- lines[[1]]
DEF <- lines [[2]]
PP <- rbind(cbind(lines[[3]],lines[[4]]),cbind(lines[[5]],lines[[6]]))
G <- lines[[7]]
INJ <- lines[[8]]
            # Pull injury type ("IR", "DTD", "OUT")
            # Sorted by Position (from NHL API)
    # FUNC TO SEARCH LINE POSITION IN ABOVE TABLE
    # FULL TEAM TABLE
        # Used to display full team for visualization
        # 3 x 7 matrix
        # No col headers
        # F on top, D lines below and split L & R w/ G in between D




