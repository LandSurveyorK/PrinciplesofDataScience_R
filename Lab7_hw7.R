#######################
### HW 7 Tidy data  ###
#######################

### Exercise 2 ###
library(tidyverse)
pew <- tbl_df(read.csv("C:/Users/jub69/Dropbox/A-Pitt/1261-PDS/CourseMaterial/Labs/Lab7/pew.csv", 
                       stringsAsFactors = FALSE,check.names = FALSE))
head(pew)

pew2 <- pew %>%
  gather(key = income,value = n, `<$10k`:`Don't know/refused`)
pew2

### Exercise 3 ###
# Make table4b tidy, by gathering the latter two columns, where key is "year", value is "population". 
#Set the name of the resulting data frame tidy4b.
tidy4b <- table4b %>% 
  gather(key = year, value = population, `1999`:`2000`)
tidy4b

### Exercise 4 ###
# Join the two tables tidy4a and tidy4b, using a two-table verb in dplyr. 
# The resuling data frame must look exactly the same as table1.

tidy4a <- 
  table4a %>% 
  gather(key = "year", value = "cases", `1999`:`2000`)

table1_join <- tidy4a %>% 
  left_join(tidy4b, by=(c("country"="country","year"="year"))) %>% 
  arrange(country,year)
table1_join

### Exercise 5 ###
# Consider the following example. What is the resulting data frame? 
# Answer this without executing the code below.
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(key = year, value = return) 

### Exercise 6 ###
# Tidy the simple tibble below. Do you need to spread or gather it? What are the variables?

pregnant <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
pregnant
# We need to gather it. The variables are pregnant and sex
pregnant2 <- pregnant %>%
  gather(key = sex, value = n, male:female)
pregnant2

### Exercise 7 ###
# In the intermediate result while tidying table 5, 
# notice that the new varible new has a not very meaningful name, 
# and its values are not numbers but characters. 
# Finish transforming table5 into the tidy form (the same as table1).

table5 %>% 
  separate(rate, into = c("cases","population"), sep = "/",convert = TRUE) %>% 
  unite(year, century, year, sep = "") %>% 
  mutate(year = as.integer(year))





