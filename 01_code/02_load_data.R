# load data for multiple years from https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire
# retrieved 2021-11-06

# load file structure (two for different years)
str_1 <- fromJSON("https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/structure-1.json")
headings_1 <- names(str_1$properties) %>% 
  str_replace_all(., ",", "") %>%
  str_replace_all(., "spetators", "spectators") 

str_2 <- fromJSON("https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/structure-2.json")
headings_2 <- names(str_2$properties) %>% 
  str_replace_all(., ",", "") %>%
  str_replace_all(., "spetators", "spectators") 

# load datasets
urls <- c("https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/data-2016-structure-1.csv",
          "https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/data-2017-structure-1.csv",
          "https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/data-2018-structure-1.csv",
          "https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/data-2019-structure-2.csv",
          "https://opendata.mkrf.ru/opendata/7705851331-stat_theatres_repertoire/data-2020-structure-2.csv")

years <- seq(2016, 2020)

for(i in seq_along(urls)){
  download.file(urls[i], here("02_data", paste0("theatre_source_", years[i], ".csv")), mode="wb")
}

# load data into R
years <- seq(2016, 2020)
file_list <- list.files(here("02_data"), pattern = ".csv")
theatre_source <- list()
for(i in seq_along(file_list)){
  theatre_source[[i]] <- read.csv(file = here("02_data", file_list[i]), encoding = "UTF-8")
  
  if(years[i] %in% c("2016", "2017", "2018")) {
    names(theatre_source[[i]]) <- headings_1
  } else {
    names(theatre_source[[i]]) <- headings_2
  }
  
  theatre_source[[i]]$year <- years[i]

}

theatre_source <- plyr::rbind.fill(theatre_source)
write_xlsx(theatre_source, here("02_data", "theatre_source.xlsx"))


# load headcount data
url <- "https://showdata.gks.ru/report/278930"
test <- read_html(url) %>% 
  # html_nodes('li') %>% 
  html_nodes('script') %>% 
  html_text()

https://showdata.gks.ru/static/bundles/slickgrid_vendor/slickgrid.netdb.core.bundle.compiled.js?v=1619125778


# load headcount data
url <- "https://showdata.gks.ru/report/278930"
download.file(url, here("02_data", "hc.hmtl"), mode="wb")
html_file <- read.csv(file = here("02_data", "hc.html"), encoding = "UTF-8")

test <- read_html(html_file) %>% html_nodes('li') %>% html_nodes('script') %>% html_text()

##
url <- "https://showdata.gks.ru/x/report/278930/view/compound/?_=1636285329681"
test <- read_html(url) %>% 
  # html_nodes('li') %>% 
  html_nodes('script') %>% 
  html_text()



###
driver <- remoteDriver()

driver <- rsDriver(
  browser = "chrome", 
)
server <- driver$server
browser <- driver$client

buttons <- list()
browser$navigate(url)

while (length(buttons) == 0) {
  buttons <- browser$findElements(button_id, using = "id")
}
buttons[[1]]$clickElement()


buttons <- browser$findElements(
  "#linkAccount > div > div.label-account",
  using = "css selector"
)

#

checkForServer()
startServer()
remDrv <- remoteDriver()
remDrv$open()

remDrv$navigate(base_url)

remDrv$getPageSource()[[1]] %>% htmlParse %>% 
  readHTMLTable(header = TRUE) %>% 
  extract2(1) %>% head

link <- 'https://showdata.gks.ru/report/278930'
test <- read_html(link) %>% 
  #html_nodes('li') %>% 
  html_nodes('script') %>% 
  html_text()
ct <- v8()

#parse the html content from the js output and print it as text
read_html(ct$eval(gsub('document.write','',emailjs))) %>% html_text()

#
library(httr)
r <-GET("https://showdata.gks.ru/report/278930")
json <- content(r,as="parsed")


# 
library(RSelenium)
driver <- remoteDriver()
driver$open()
driver$navigate("https://www.google.com/")

remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4445L,
  browserName = "firefox"
)
remDr$open()
