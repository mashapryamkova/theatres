
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
