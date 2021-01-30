library(readr)
library(dplyr)

# Open Covid dataset for state of ohio by The COVID Tracking project - covidtracking.com 
data <- read_csv("https://covidtracking.com/data/download/ohio-history.csv")

# Summary of all the columns
#summary(data)
#View(data)

# convert table to dataframe
as.data.frame(data)

# ------ Print descriptive statistics for quantitative variable ----------
# using https://dplyr.tidyverse.org/reference/summarise_all.html
# article on dplyr: https://uc-r.github.io/dplyr
# piping/chaining functions to select the columns death and hospitalized and calulate their mean, min and max
# remove  NA
data %>% 
  summarise_at(c("death", "hospitalized"), list(min = min, max = max, mean = mean), na.rm = TRUE)

# ------ Print descriptive statistics for categorical variable ----------
# All the data that have lower quality grade (B)
data %>% 
  filter(dataQualityGrade == 'B')

# ---- Transform variable. ---------
# Get mean for columns death and hospatilized grouped by their data quality
data %>%
  group_by(dataQualityGrade)%>% 
  summarise(Death = mean(death, na.rm=TRUE),
            Hospitalized = mean(hospitalized, na.rm=TRUE))

# ----- Plot deaths vs days only for data with quality A+
filtered_Data <- data %>% 
  filter(dataQualityGrade == 'B') %>%
  select(date, death)

#head(filtered_Data)

plot(filtered_Data)

