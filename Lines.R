library(tidyverse)
library(rvest)

# TEAM NAMES FUNCTION
team <- function (n) {
   tm <- read_html("https://www.dailyfaceoff.com/teams/") %>%
        html_nodes(".team-list-name") %>%
        html_text() %>%
        tolower() %>%
        gsub(pattern = " ",replacement = "-")
   tm_page <<- str_glue("https://www.dailyfaceoff.com/teams/",{tm[n]},"/line-combinations/")
}
    
team(19)
tm_page

# LINES FUNCTION
line_create <- function(node,n) {
    read_html(tm_page) %>%
        html_nodes(node) %>%
        html_nodes(".player-name") %>%
        html_text %>%
        matrix(n) %>%
        t() %>%
        as_tibble()
}

lines <- read.csv("nodes.csv") %>%
    pmap(line_create)

FWD <- lines[[1]]
DEF <- lines [[2]]
PP <- rbind(cbind(lines[[3]],lines[[4]]),cbind(lines[[5]],lines[[6]]))
G <- lines[[7]]
INJ <- tryCatch(lines[[8]],error=function(e) NA)

            # Pull injury type ("IR", "DTD", "OUT")
            # Sorted by Position (from NHL API)
    # FUNC TO SEARCH LINE POSITION IN ABOVE TABLE
    # FULL TEAM TABLE
        # Used to display full team for visualization
        # 3 x 7 matrix
        # No col headers
        # F on top, D lines below and split L & R w/ G in between D


easy <- function(){
    return(list(fnm="ryan",lnm="bulger"))
}
easy <- easy()
easy$fnm
