###################
### Lab 5 R code ###
###################
library(dplry)
library(Hmisc)
library(mdsr)
library(babynames)
BabynamesDist <- make_babynames_dist()
head(BabynamesDist, 2)

## 1. "Most common women's name

com_fem <- BabynamesDist %>%
  filter(sex == "F") %>%
  group_by(name) %>% 
  mutate(N=n()) %>% 
  filter(N>=4) %>% 
  summarise(
    est_num_alive = sum(est_alive_today),
    q1_age = wtd.quantile(age_today, est_alive_today, probs = 0.25),
    median_age = wtd.quantile(age_today, est_alive_today, probs = 0.5),
    q3_age = wtd.quantile(age_today, est_alive_today, probs = 0.75)
  ) %>%
  arrange(desc(est_num_alive)) %>%
  head(25)

w_plot <- ggplot(
  data = com_fem, 
  aes(x = reorder(name, -median_age),  y = median_age)
) + 
  xlab(NULL) + 
  ylab("Age (in years)") +
  ggtitle("Median ages for males with the 25 most common names")

w_plot + 
  geom_linerange(
    aes(ymin = q1_age, ymax = q3_age),
    color = "#f3d478", 
    size = 5, 
    alpha = 0.8
  ) + 
  geom_point(fill = "#ed3324", colour = "white", size = 4, shape = 21) +
  coord_flip()


## 2. Summarizing groups

babynames1 <- babynames %>%
  filter(name == "Jackie") %>%
  group_by(year) %>%
  summarise(
    N = n(), 
    total = sum(n), 
    boys = sum(ifelse(sex == "M",n, 0)) 
  )
babynames1 

