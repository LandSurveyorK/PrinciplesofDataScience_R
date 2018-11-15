###################
### HW 5 R code ###
###################

### Problem 1 ###
# Part a: Recreate the plot #

library(Hmisc)
library(mdsr)
library(babynames)
BabynamesDist <- make_babynames_dist()
head(BabynamesDist, 2)
com_male <- BabynamesDist %>%
  filter(sex == "M") %>%
  group_by(name) %>% 
  mutate(est_num_alive = sum(est_alive_today)) %>% 
  filter(est_num_alive >= 100000) %>%
  summarise(
    est_num_alive = sum(est_alive_today),
    q1_age = wtd.quantile(age_today, est_alive_today, probs = 0.25),
    median_age = wtd.quantile(age_today, est_alive_today, probs = 0.5),
    q3_age = wtd.quantile(age_today, est_alive_today, probs = 0.75)
  ) %>%
  arrange(median_age) %>%
  head(25)

w_plot <- ggplot(
  data = com_male, 
  aes(x = reorder(name, -median_age),  y = median_age)
) + 
  xlab(NULL) + 
  ylab("Age (in years)") +
  ggtitle("Youngest Male Names")

w_plot + 
  geom_linerange(
    aes(ymin = q1_age, ymax = q3_age),
    color = "#99badd", 
    size = 5, 
    alpha = 0.8
  ) + 
  geom_point(fill = "#ed3324", colour = "white", size = 4, shape = 21) +
  geom_point(aes(y=21,x=24),fill = "#ed3324", colour = "white", size = 3, shape = 21) +
  geom_text(aes(y=22,x=24),label="median",cex=3.8)+
  geom_text(aes(y=9,x=14),label="25th",cex=3.8)+
  geom_text(aes(y=21,x=14),label="75th percentile",cex=3.8)+
  geom_point(aes(y=8,x=14),shape=17)+
  geom_point(aes(y=23,x=14),shape=17)+
  geom_hline(yintercept=seq(5,25,5),lty=2)+
  scale_y_continuous(name="Age (in years)",breaks=seq(5,25,5), labels=c("5", "10", "15", "20","25"))+
  coord_flip()

### Problem 2 ###

Jackie <- babynames %>%
  filter(name == "Jackie") %>%
  group_by(year) %>%
  summarise(
    N = n(), 
    total = sum(n), 
    boys = sum(ifelse(sex == "M",n, 0)) 
  )  %>% 
  mutate(diff0.5 = abs(0.5-boys/total)) %>% 
  arrange(diff0.5) %>% 
  head(10)
Jackie

### Problem 3 ###
HighBirth <- babynames %>% 
  group_by(year) %>% 
  summarise(
    total = sum(n)
  ) %>% 
  arrange(desc(total)) %>% 
  head(5)
HighBirth

### Problem 4 ###
appear <- babynames %>%
  group_by(name) %>% 
  summarise(
    EarliestYear= min(year),
    LatestYear = max(year)
  )
head(appear)

### Problem 5 ###
YoungPop <- babynames %>%
  filter(prop >= 0.01) %>% 
  group_by(name) %>% 
  summarise(
    EarliestYear= min(year)
  ) %>% 
  arrange(desc(EarliestYear)) %>% 
  head(10)
YoungPop

### Problem 6 ###
NumNames <- babynames %>%
  group_by(year) %>% 
  summarise(
#    NumNames=length(unique(name))
    NumNames=n_distinct(name)
  ) 
ggplot(NumNames,mapping=aes(x=year,y=NumNames))+
  geom_line()

# by gender
NumNames2 <- babynames %>%
  group_by(year,sex,add=TRUE) %>% 
  summarise(
#    NumNames=length(unique(name))
    NumNames=n_distinct(name)
  ) 

ggplot(NumNames2,mapping=aes(x=year,y=NumNames))+
  geom_line()+
  facet_wrap(~sex)

### Problem 7 ###
Popular90s <- babynames %>%
  group_by(name) %>% 
  filter(year >=1990 & year < 2000) %>%
  summarise(
    total=sum(n)
  ) %>% 
  arrange(desc(total)) %>% 
  head(10)

Popular90s
  
  







