####################
### Lab 7 + HW 6 ###
####################

#install.packages("Lahman")
library(Lahman)
library(dplyr)
manny <- Batting %>%  
  filter(playerID == "ramirma02")

### Exercise 1 ###
nrow(manny)

manny %>% summarize(
  span = paste(min(yearID), max(yearID), sep = "-"),
  numYears = n_distinct(yearID), numTeams = n_distinct(teamID),
  BA = sum(H)/sum(AB), tH = sum(H), tHR = sum(HR), tRBI = sum(RBI)
)

### Exercise 2 ###
manny %>% 
  group_by(teamID) %>% 
  summarize(
  span = paste(min(yearID), max(yearID), sep = "-"),
  numYears = n_distinct(yearID),
  BA = sum(H)/sum(AB), tH = sum(H), tHR = sum(HR), tRBI = sum(RBI)
) %>% 
  arrange(span)

### Exercise 3 ###
mannyAllstar <- AllstarFull %>% filter(playerID == "ramirma02")

mannyBySeason %>% 
  inner_join(mannyAllstar, by = c("yearID" = "yearID")) %>%
  select(yearID, Age, OPS, GP, startingPos)  # 12 rows

### Exercise 4 ###
Batting %>% 
  left_join(Master,by = c("playerID" = "playerID")) %>%
  group_by(playerID) %>% 
  summarise(
    FirstName = unique(nameFirst),
    LastName = unique(nameLast),
    TotalHR = sum(HR)
  ) %>% 
  arrange(desc(TotalHR)) %>% 
  head(20)
  
### Exercise 5 ###
Pitching %>% 
  group_by(playerID) %>% 
  left_join(Master,by = c("playerID" = "playerID")) %>% 
  summarise(
    FirstName = unique(nameFirst),
    LastName = unique(nameLast),
    span = paste(min(yearID),"-",max(yearID)),
    totalWin = sum(W),
    totalSO = sum(SO)
  ) %>% 
  filter(totalWin >= 300 & totalSO >= 3000) %>%
  arrange(desc(totalWin+totalSO))

### Exercise 6 ###
AwardsPlayers %>% 
  filter(awardID == "World Series MVP") %>% 
  left_join(Master,by = c("playerID" = "playerID")) %>%
  group_by(playerID) %>% 
  summarise(
    Year = max(yearID),
    FirstName = unique(nameFirst),
    LastName = unique(nameLast),
    Age = max(yearID - birthYear)
  ) %>% 
  arrange(desc(Year)) %>% 
  head(10)
  














