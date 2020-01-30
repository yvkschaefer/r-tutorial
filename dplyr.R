# Reference: https://genomicsclass.github.io/book/pages/dplyr_tutorial.html

library(dplyr)

msleep <- read.csv(file.path("./data_raw/msleep_ggplot2.csv"))


# important dplyr verbs to remember
# select()      select columns
# filter()      filter rows
# arrange()     re-order or arrange rows
# mutate()      create new columns
# summarise()   summarise values
# group_by()    allows for group operations in the "split-apply-combine" concept


# select several columns
head(select(msleep, name, sleep_total))
msleep %>% 
  select(name, sleep_total) %>% 
  head


# to select all but a specific column, use the subtraction operator
head(select(msleep, -name))


# to select a range of columns by name, use the ":" (colon) operator
head(select(msleep, name:order))


# to select all columns that start with the character string "sl", use the function starts_with()
head(select(msleep, starts_with("sl")))


# some other ways to select columns based on specific criteria
## ends_with()  select columns that end with a characer string
## contains()   select columns that contain a character string
## matches()    select columns that match a regular expression
## one_of()     select columns names that are from a group of names

head(select(msleep, matches("a")))

# filter the rows for mammals that sleep a total of more than 16 hours

head(msleep)

msleep %>% 
  filter(sleep_total > 16.0 & bodywt > 1)



# column name	Description
# name	common name
# genus	taxonomic rank
# vore	carnivore, omnivore or herbivore?
# order	taxonomic rank


# Filter the rows for mammals in the Perissodactyla and Primates taxonomic order
msleep %>% 
  filter(order %in% c("Perissodactyla", "Primates"))


# to arrange or re-order rows by a particular column such as the taxonomic order, list the name of the column you want to arrange the rows by
msleep %>% 
  arrange(order) %>% 
  head

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, desc(sleep_total)) %>% 
  filter(sleep_total >= 16)


colnames(msleep)

msleep %>% 
  select(name, sleep_rem, sleep_total, bodywt) %>% 
  mutate(rem_proportion = sleep_rem/sleep_total,
         bodywt_grams = bodywt * 1000) %>% 
  head


msleep %>% 
  summarise(avg_sleep = mean(sleep_total))
# summarise returns one row, in this case:
#   avg_sleep
# 1  10.43373

msleep %>% 
  summarise(avg_sleep = mean(sleep_total),
            min_sleep = min(sleep_total),
            max_sleep = max(sleep_total),
            total = n())


# group_by()
# we want to split the data frame by some variable (eg. taxonomic order), apply a function to the individual data frames and then combine the output.

msleep %>% 
  group_by(order) %>% 
  summarise(avg_sleep = mean(sleep_total),
            min_sleep = min(sleep_total),
            max_sleep = max(sleep_total),
            total = n())
