### Creating objects in R
















### Challenge
##
## What are the values after each statement 

mass <- 47.5            # mass? 47.5
age  <- 122             # age? 122
mass <- mass * 2.0      # mass? 95
age  <- age - 20        # age? 102
mass_index <- mass/age  # mass_index? 0.9313725

mass
age
mass_index














### Vectors and data types





















## ## Weâ€™ve seen that atomic vectors can be of type character, numeric, integer, and
## ## logical. But what happens if we try to mix these types in a single
## ## vector?
## 
## ## What will happen in each of these examples? (hint: use `class()` to
## ## check the data type of your object)

num_char <- c(1, 2, 3, "a") # character type

num_logical <- c(1, 2, 3, TRUE) # double

char_logical <- c("a", "b", "c", TRUE) # character

tricky <- c(1, 2, 3, "4") # character

## ## Why do you think it happens?
## 
## ## You've probably noticed that objects of different types get
## ## converted into a single, shared type within a vector. In R, we call
## ## converting objects from one class into another class
## ## _coercion_. These conversions happen according to a hierarchy,
## ## whereby some types get preferentially coerced into other types. Can
## ## you draw a diagram that represents the hierarchy of how these data
## ## types are coerced?

# 1. character
# 2. numeric/double
# 3. logical/boolean











### Challenge (optional)
##
## * Can you figure out why `"four" > "five"` returns `TRUE`?

# from site:

# When using “>” or “<” on strings, R compares their alphabetical order. Here “four” comes after “five”, and therefore is “greater than” it. 





heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

## Extract those elements which are not missing values.
heights_no_na <- heights[!is.na(heights)] 
# or
## Returns the object with incomplete cases removed. The returned object is an atomic vector of type `"numeric"` (aka `"double"`)
heights_no_na <- na.omit(heights)
# or
## Extract those elements which are complete cases. The returned object is an atomic vector of type `"numeric"` (aka `"double"`)
heights_no_na <- heights[complete.cases(heights)]

# 2.
median(heights, na.rm = TRUE)

# 3.
heights_above_67 <- heights_no_na[heights_no_na > 67]
length(heights_above_67)

## ### Challenge
## 1. Using this vector of heights in inches, create a new vector with the NAs removed.
##
   heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
heights_no_na <- heights[complete.cases(heights)]
heights
isNa <- heights[is.na(heights)]
isNa
length(heights)
length(heights) - length(isNa) - length(heights_no_na)
heights_no_na
length(heights_no_na)
##
## 2. Use the function `median()` to calculate the median of the `heights` vector.

median(heights_no_na) # 64
median(heights, na.rm = TRUE) # 64

## 3. Use R to figure out how many people in the set are taller than 67 inches.

heights_above_67 <- length(heights_no_na[heights_no_na > 67])
heights_above_67 # 6


### Presentation of the survey data

download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

surveys <- read.csv("data_raw/portal_data_joined.csv")
head(surveys)
View(surveys)
str(surveys)

# size
dim(surveys) # returns a vector with the number of rows in the first element, and the number of columns as the second element (the _dim_ensions of the object)
nrow(surveys) # returns the number of rows
ncol(surveys) # returns the number of columns

# content
head(surveys) # shows the first 6 rows
tail(surveys) # shows the last 6 rows

# names
names(surveys) # returns the column names (synonym of colnames() for data.frame objects)
rownames(surveys) # returns the row names

# summary
str(surveys) # structure of the object and information about the class, length and content of each column
summary(surveys) # summary statistics for each column






## Challenge
## Based on the output of `str(surveys)`, can you answer the following questions?
## * What is the class of the object `surveys`?
# data frame

## * How many rows and how many columns are in this object?
# rows: 34786; columns: 13

## * How many species have been recorded during these surveys?
# 48



## Indexing and subsetting data frames









### Challenges:
###
### 1. Create a `data.frame` (`surveys_200`) containing only the
###    data in row 200 of the `surveys` dataset.
surveys_200 <- surveys[200,]


### 2. Notice how `nrow()` gave you the number of rows in a `data.frame`?
###
###      * Use that number to pull out just that last row in the data frame
###      * Compare that with what you see as the last row using `tail()` to make
###        sure it's meeting expectations.
###      * Pull out that last row using `nrow()` instead of the row number
###      * Create a new data frame object (`surveys_last`) from that last row
# Saving `n_rows` to improve readability and reduce duplication
n_rows <- nrow(surveys)
surveys_last <- surveys[n_rows,]
surveys_last
tail(surveys)

### 3. Use `nrow()` to extract the row that is in the middle of the
###    data frame. Store the content of this row in an object named
###    `surveys_middle`.
surveys_middle <- surveys[n_rows/2,]
surveys_middle


### 4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
###    `head(surveys)`, keeping just the first through 6th rows of the surveys
###    dataset.
surveys_head <- surveys[-c(7:n_rows), ]
surveys_head

### Factors

sex <- factor(c("male", "female", "female", "male"))







year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)               # Wrong! And there is no warning...
as.numeric(as.character(year_fct)) # Works...
as.numeric(levels(year_fct))[year_fct]    # The recommended way.

## bar plot of the number of females and males captured during the experiment:
plot(surveys$sex)





## Challenges
##
## * Rename "F" and "M" to "female" and "male" respectively.
levels(sex)[2:3] <- c("female", "male")


## * Now that we have renamed the factor level to "undetermined", can you recreate the
##   barplot such that "undetermined" is last (after "male")
sex <- factor(sex, levels = c("female", "male", "undetermined"))
plot(sex)

## ## Compare the difference between our data read as `factor` vs `character`.
surveys <- read.csv("data_raw/portal_data_joined.csv", stringsAsFactors = TRUE)
str(surveys)
surveys <- read.csv("data_raw/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys)
## ## Convert the column "plot_type" into a factor
surveys$plot_type <- factor(surveys$plot_type)



## ## Challenge:
## ##  There are a few mistakes in this hand-crafted `data.frame`,
## ##  can you spot and fix them? Don't hesitate to experiment!
animal_data <- data.frame(
      animal = c("dog", "cat", "sea cucumber", "sea urchin"),
      feel = c("furry", "furry", "squishy", "spiny"),
      weight = c(45, 8, 1.1, 0.8)
      )
animal_data


## ## Challenge:
## ##   Can you predict the class for each of the columns in the following
## ##   example? character, character, character, character, numeric
## ##   Check your guesses using `str(country_climate)`:
## ##   * Are they what you expected? Why? why not?
## ##   * What would have been different if we had added `stringsAsFactors = FALSE`
## ##     when we created this data frame?
## ##   * What would you need to change to ensure that each column had the
## ##     accurate data type?
country_climate <- data.frame(country = c("Canada", "Panama", "South Africa", "Australia"),
                               climate = c("cold", "hot", "temperate", "hot/temperate"),
                               temperature = c(10, 30, 18, 15),
                               northern_hemisphere = c(TRUE, TRUE, FALSE, FALSE),
                               has_kangaroo = c(FALSE, FALSE, FALSE, TRUE))

library(lubridate)


my_date <- ymd("2015-01-01")
str(my_date)
# sep indicates the character to use to separate each component
my_date <- ymd(paste("2015", "1", "1", sep = "-"))
str(my_date)

paste(surveys$year, surveys$month, surveys$day, sep = "-")
ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
summary(surveys$date)

# let's see what's happening with our 129 NAs, our missing date rows
missing_dates <- surveys[is.na(surveys$date), c("year", "month", "day")]
head(missing_dates)
# seems like every date row that didn't parse was in the year 2000. let's confirm if this is true by checking to see if any date rows that _did_ parse were in the year 2000

sum(surveys$year == 2000)
sum(surveys$year == 2000, na.rm = TRUE)
# both of the above commands return 1509, which is != 129.

#It seems like the non-parsed dates are either September 31st 2000 or April 31st 2000, neither of those days are real dates if you look at a calendar from the year 2000, or this year... I would omit those data points as seems to be happening anyway, because the dates are clearly wrong.


## load the tidyverse packages, including dplyr
library(tidyverse)
surveys <- read_csv("data_raw/portal_data_joined.csv")
## inspect the data
str(surveys)
## preview the data
View(surveys)


select(surveys, plot_id, species_id, weight)
select(surveys, -record_id, -species_id)
filter(surveys, year == 1995)


surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)


## ## Pipes Challenge:
## ##  Using pipes, subset the data to include animals collected
## ##  before 1995, and retain the columns `year`, `sex`, and `weight.`

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)








surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000) %>% 
  select(weight, weight_kg)

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  select(-month, -day, -hindfoot_length, -plot_type) %>% 
  head()


## ## Mutate Challenge:
## ##  Create a new data frame from the `surveys` data that meets the following
## ##  criteria: contains only the `species_id` column and a column that
## ##  contains values that are half the `hindfoot_length` values (e.g. a
## ##  new column `hindfoot_half`). In this `hindfoot_half` column, there are
## ##  no NA values and all values are < 30.
## 
## ##  Hint: think about how the commands should be ordered to produce this data frame!



surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_length, hindfoot_half)



surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(desc(min_weight)) %>% 
  print(n = 15)

surveys %>% 
  count(sex)

surveys %>% 
  count(sex, species) %>% 
  arrange(species, desc(n))




## ## Count Challenges:
## ##  1. How many animals were caught in each `plot_type` surveyed?

surveys %>% 
  count(plot_type)

## ##  2. Use `group_by()` and `summarize()` to find the mean, min, and max
## ## hindfoot length for each species (using `species_id`). Also add the number of
## ## observations (hint: see `?n`).

surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarize(
    mean_hindfoot_length = mean(hindfoot_length),
    min_hindfoot_length = min(hindfoot_length),
    max_hindfoot_length = max(hindfoot_length),
    n = n()
    )

## ##  3. What was the heaviest animal measured in each year? Return the
## ##  columns `year`, `genus`, `species_id`, and `weight`.

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% 
  select(year, genus, species_id, weight) %>% 
  arrange(year) %>% 
  print(n = 30)



surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

str(surveys_gw)

surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight)

str(surveys_spread)

View(surveys_gw)
View(surveys_spread)

surveys_gw %>% 
  spread(genus, mean_weight, fill = 0) %>% 
  head()

surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id)

str(surveys_gather)
View(surveys_gather)

surveys_spread %>% 
  gather(key = genus, value = mean_weight, Baiomys:Spermophilus) %>% 
  head()

## ## Reshaping challenges
## 
## ## 1. Make a wide data frame with `year` as columns, `plot_id`` as rows, and where the values are the number of genera per plot. You will need to summarize before reshaping, and use the function `n_distinct` to get the number of unique genera within a chunk of data. It's a powerful function! See `?n_distinct` for more.

rich_time <- surveys %>% 
  group_by(plot_id, year) %>% 
  summarize(n_genera = n_distinct(genus)) %>% 
  spread(year, n_genera)

View(rich_time)
head(rich_time)


## ## 2. Now take that data frame, and make it long again, so each row is a unique `plot_id` `year` combination

rich_time %>% 
  gather(year, n_genera, -plot_id)

## ## 3. The `surveys` data set is not truly wide or long because there are two columns of measurement - `hindfoot_length` and `weight`.  This makes it difficult to do things like look at the relationship between mean values of each measurement per year in different plot types. Let's walk through a common solution for this type of problem. First, use `gather` to create a truly long dataset where we have a key column called `measurement` and a `value` column that takes on the value of either `hindfoot_length` or `weight`. Hint: You'll need to specify which columns are being gathered.

surveys_long <- surveys %>% 
  gather(measurement, value, hindfoot_length, weight)

## ## 4. With this new truly long data set, calculate the average of each `measurement` in each `year` for each different `plot_type`. Then `spread` them into a wide data set with a column for `hindfoot_length` and `weight`. Hint: Remember, you only need to specify the key and value columns for `spread`.

surveys

surveys_long %>% 
  group_by(year, measurement, plot_type) %>% 
  summarize(mean_value = mean(value, na.rm = TRUE)) %>% 
  spread(measurement, mean_value)




## ### Create the dataset for exporting:
## ##  Start by removing observations for which the `species_id`, `weight`,
## ##  `hindfoot_length`, or `sex` data are missing:
## surveys_complete <- surveys %>%
##     filter(species_id != "",        # remove missing species_id
##            !is.na(weight),                 # remove missing weight
##            !is.na(hindfoot_length),        # remove missing hindfoot_length
##            sex != "")                      # remove missing sex
## 
surveys_complete <- surveys %>% 
  filter(!is.na(weight),
         !is.na(hindfoot_length),
         !is.na(sex))

## ##  Now remove rare species in two steps. First, make a list of species which
## ##  appear at least 50 times in our dataset:
## species_counts <- surveys_complete %>%
##     count(species_id) %>%
##     filter(n >= 50) %>%
##     select(species_id)
## 
species_counts <- surveys_complete %>% 
  count(species_id) %>% 
  filter(n >= 50)
## ##  Second, keep only those species:
## surveys_complete <- surveys_complete %>%
##     filter(species_id %in% species_counts$species_id)
surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

dim(surveys_complete)

write_csv(surveys_complete, path="data/surveys_complete.csv")

### Data Visualization with ggplot2

library(tidyverse)

# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) + <GEOM_FUNCTION>()

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + geom_point()

# Assign plot to a variable
surveys_plot <- ggplot(data = surveys_complete,
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw the plot
surveys_plot + geom_point()



install.packages("hexbin")
library(hexbin)

surveys_plot +
 geom_hex()

## ### Challenge with hexbin
## ##
## ## To use the hexagonal binning with **`ggplot2`**, first install the `hexbin`
## ## package from CRAN:
## 
## install.packages("hexbin")
## library(hexbin)
## 
## ## Then use the `geom_hex()` function:
## 
## surveys_plot +
##     geom_hex()
## 
## ## What are the relative strengths and weaknesses of a hexagonal bin
## ## plot compared to a scatter plot?
# The hexagonal bin shows you the concentrated areas, which gives you more context.

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) + geom_jitter()


ggplot(data = surveys_complete, mapping = aes(x = weight, y = species_id, color = plot_type)) + geom_point()





## ## Challenge with boxplots:
## ##  Start with the boxplot we created:
## ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
##   geom_boxplot(alpha = 0) +
##   geom_jitter(alpha = 0.3, color = "tomato")
## 
## ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
## 
## ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
## 
## ##  3. Create boxplot for `hindfoot_length` overlaid on a jitter layer.
## 
## ##  4. Add color to the data points on your boxplot according to the
## ##  plot from which the sample was taken (`plot_id`).
## ##  *Hint:* Check the class for `plot_id`. Consider changing the class
## ##  of `plot_id` from integer to factor. Why does this change how R
## ##  makes the graph?
## 


ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "pink") + 
  geom_violin() +
  scale_y_log10()

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "pink") + 
  geom_boxplot(alpha = 0)

surveys_complete$plot_id <- as.factor(surveys_complete$plot_id)

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = hindfoot_length, color = plot_id)) +
  geom_jitter(alpha = 0.5) +
  geom_boxplot(alpha = 0.2)






yearly_counts <- surveys_complete %>% 
  count(year,genus)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = genus)) + geom_line()




# FACETS

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap((facets = vars(genus)))

yearly_sex_counts <- surveys_complete %>% 
  count(year, genus, sex)

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex
                     )
       ) +
  geom_line() +
  facet_wrap(facets = vars(genus))

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols = vars(genus))

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))


ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  theme_minimal()








## ### Plotting time series challenge:
## ##
## ##  Use what you just learned to create a plot that depicts how the
## ##  average weight of each species changes through the years.

yearly_weight <- surveys_complete %>% 
  group_by(year, species) %>% 
  summarize(avg_weight = mean(weight))

ggplot(data = yearly_weight,
       mapping = aes(x = year,
                     y = avg_weight)) +
  geom_line() +
  facet_wrap(vars(species)) +
  theme_bw()


ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera over time",
       x = "Year of observation",
       y = "Number of Individuals") +
  theme_bw() +
  theme(text = element_text(size = 16),
        axis.text.x = element_text(color = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(color = "grey20", size = 12))

# define custom theme
grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", size = 12),
                    text = element_text(size = 16))

# create a boxplot with the new theme
ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot() +
  grey_theme




install.packages("gridExtra")




# WIP STILL
## ### Final plotting challenge:
## ##  With all of this information in hand, please take another five
## ##  minutes to either improve one of the plots generated in this
## ##  exercise or create a beautiful graph of your own. Use the RStudio
## ##  ggplot2 cheat sheet for inspiration:
## ##  https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf



library(gridExtra)

spp_weight_boxplot <- ggplot(data = surveys_complete, 
                             mapping = aes(x = genus, y = weight)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(x = "Genus", y = "Weight (g)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

spp_count_plot <- ggplot(data = yearly_counts, 
                         mapping = aes(x = year, y = n, color = genus)) +
  geom_line() + 
  labs(x = "Year", y = "Abundance")

grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))


my_plot <- ggplot(data = yearly_sex_counts, 
                  mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(species_id)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text=element_text(size = 16))
ggsave("fig/yearly_sex_counts.png", my_plot, width = 15, height = 10)

# This also works for grid.arrange() plots
combo_plot <- grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))
ggsave("fig/combo_plot_abun_weight.png", combo_plot, width = 10, dpi = 300)


## SQL databases and R

## install.packages(c("dbplyr", "RSQLite"))



library(dplyr)
library(dbplyr)
mammals <- DBI::dbConnect(RSQLite::SQLite(), "data_raw/portal_mammals.sqlite")

src_dbi(mammals)

tbl(mammals, sql("SELECT year, species_id, plot_id FROM surveys"))

surveys <- tbl(mammals, "surveys")
surveys %>%
  select(year, species_id, plot_id)



















## with dplyr syntax
species <- tbl(mammals, "species")

left_join(surveys, species) %>%
  filter(taxa == "Rodent") %>%
  group_by(taxa, year) %>%
  tally %>%
  collect()

## with SQL syntax
query <- paste("
SELECT a.year, b.taxa,count(*) as count
FROM surveys a
JOIN species b
ON a.species_id = b.species_id
AND b.taxa = 'Rodent'
GROUP BY a.year, b.taxa",
               sep = "" )

tbl(mammals, sql(query))



### Challenge
## Write a query that returns the number of rodents observed in each
## plot in each year.

##  Hint: Connect to the species table and write a query that joins
##  the species and survey tables together to exclude all
##  non-rodents. The query should return counts of rodents by year.

## Optional: Write a query in SQL that will produce the same
## result. You can join multiple tables together using the following
## syntax where foreign key refers to your unique id (e.g.,
## `species_id`):

## SELECT table.col, table.col
## FROM table1 JOIN table2
## ON table1.key = table2.key
## JOIN table3 ON table2.key = table3.key


## species <- tbl(mammals, "species")
## genus_counts <- left_join(surveys, plots) %>%
##   left_join(species) %>%
##   filter(taxa == "Rodent") %>%
##   group_by(plot_type, genus) %>%
##   tally %>%
##   collect()

### Challenge

## Write a query that returns the total number of rodents in each
## genus caught in the different plot types.

##  Hint: Write a query that joins the species, plot, and survey
##  tables together.  The query should return counts of genus by plot
##  type.



download.file("https://ndownloader.figshare.com/files/3299483",
              "data_raw/species.csv")
download.file("https://ndownloader.figshare.com/files/10717177",
              "data_raw/surveys.csv")
download.file("https://ndownloader.figshare.com/files/3299474",
              "data_raw/plots.csv")
library(tidyverse)
species <- read_csv("data_raw/species.csv")
surveys <- read_csv("data_raw/surveys.csv")
plots <- read_csv("data_raw/plots.csv")

my_db_file <- "data/portal-database-output.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)

my_db



### Challenge

## Add the remaining species table to the my_db database and run some
## of your queries from earlier in the lesson to verify that you
## have faithfully recreated the mammals database.




# Loops and Functions
# https://erdavenport.github.io/R-ecology-lesson/03-loops-and-functions.html#loops
# note to self: do not feel the need to go further than I did in the tutorial from her site. The last challenge I tried for 'loops' I wasn't able to get the solution and she doesn't provide it. A bit demoralizing.

for(i in 1:10) {
  print(i)
}

for (i in c("cat", "dog", "gerbil")) {
  print(i)
}

dim(surveys)[1]
head(surveys)
head(1:dim(surveys)[1])
tail(1:dim(surveys)[1])
for (i in 1:dim(surveys)[1]) {
  if(surveys$year[i] == 1988) {
    print("Hey, it's 1988 :)")
  } else {
   print("It isn't 1988.") 
  }
}

na <- surveys %>% 
  filter(!is.na(weight)) %>%
  filter(year == 1988)
  select(weight)
  pull()
dim(na)

dim(surveys)

surveys_adjusted <- surveys

count <- 0
for(i in 1:dim(surveys_adjusted)[1]) {
  if(surveys_adjusted$year[i] == 1988) {
    surveys_adjusted$weight[i] <- (surveys_adjusted$weight[i]*1.1) 
    count = count + 1
  }
}
count
original_1988_weight <- mean(surveys$weight[surveys$year == 1988], na.rm = TRUE)
original_1988_weight # 45.05576

adjusted_1988_weight <- mean(surveys_adjusted$weight[surveys_adjusted$year == 1988], na.rm = TRUE)
adjusted_1988_weight # 49.56134

original_1988_weight * 1.1 # 49.56134

write.table(surveys_adjusted, "data/survey_data_1988_weights_adjusted.csv", sep = ",", row.names = FALSE, quote=FALSE)
write.table(surveys_adjusted, "data/survey_data_1988_weights_adjusted_with_row_names.csv", sep = ",", row.names = TRUE, quote=FALSE)

surveys_adjusted_from_file <- read.csv("data/survey_data_1988_weights_adjusted.csv")
surveys_adjusted_from_file_row_names <- read.csv("data/survey_data_1988_weights_adjusted_with_row_names.csv")
View(surveys_adjusted_from_file)
View(surveys_adjusted_from_file_row_names) # not seeing a difference. I think the row names are just increasing integers, which, is the same as default ?
