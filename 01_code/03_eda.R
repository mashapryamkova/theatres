# If df not loaded to memory - load it

if(!exists("theatre_source")) { 
  theatre_source  <- read_excel(path = here("02_data", "theatre_source.xlsx"))
  }

# inspect
str(theatre_source)
table(theatre_source$year)
na_count <- as.data.frame(t(theatre_source %>% summarise_all(~(sum(is.na(.))))))

dfSummary(theatre_source)

# theatres renamed! Good they have Kopuk
theatre_source %>% filter(grepl("?????????? ?????", theatre_name)) %>% distinct(theatre_name)
theatre_source %>% filter(kopuk == "40027") %>% distinct(theatre_name)

# clean data
theatre_clean <- theatre_source %>%
  mutate_at(vars(number_of_spectators_total, number_of_spectators_stationary), ~(.*1000))

# count of theatres & spectators by year
theatre_clean %>%
  group_by(year) %>%
  summarize(t_count = length(unique(theatre_name)),
            spectator_count = sum(number_of_spectators_total, na.rm = TRUE)) %>%
  ungroup()

# top-10 most popular theatres by year
top_theatres <- theatre_clean %>%
  group_by(year, theatre_name, subject_name) %>%
  summarize(spectator_count = sum(number_of_spectators_total, na.rm = TRUE)) %>%
  group_by(year) %>%
  slice_max(order_by = spectator_count, n = 5)

# top-10 most popular plays and authors by year
top_plays <- theatre_clean %>%
  group_by(year, composition_id, composition_name, authors) %>%
  summarize(spectator_count = sum(number_of_spectators_total, na.rm = TRUE)) %>%
  group_by(year) %>%
  slice_max(order_by = spectator_count, n = 5)

