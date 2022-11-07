## Clean data for participants

library(magrittr)
library(dplyr)
library(expss)

heart_failure <- readr::read_csv("data//heart_failure_raw.csv")

summary(heart_failure)

heart_failure %<>%
  mutate(anaemia  = recode_factor(anaemia, `0` = "No", `1` = "Yes"),
         diabetes = recode_factor(diabetes, `0` = "No", `1` = "Yes"),
         hypertension = recode_factor(high_blood_pressure, `0` = "No", `1` = "Yes"),
         sex = recode_factor(sex, `0` = "Female", `1` = "Male"),
         smoking = recode_factor(smoking, `0` = "No", `1` = "Yes"),
         deceased = recode_factor(DEATH_EVENT, `0` = "No", `1` = "Yes"),
         follow_up = time) %>%
  select(-c(DEATH_EVENT, high_blood_pressure, time))

heart_failure <- data.frame(heart_failure)

saveRDS(heart_failure, file = "data//heart_failure.RDS")
readRDS("data//heart_failure.RDS")


readr::write_csv(heart_failure, "data//heart_failure.csv")
readr::read_csv("data//heart_failure.csv", 
                col_types = "dfdfddddffffd")

haven::write_sav(heart_failure, "data//heart_failure.sav")
haven::read_sav("data//heart_failure.sav") %>%
  mutate(anaemia = haven::as_factor(anaemia),
         diabetes = haven::as_factor(anaemia),
         sex = haven::as_factor(anaemia),
         smoking = haven::as_factor(anaemia),
         hypertension = haven::as_factor(hypertension),
         deceased = haven::as_factor(deceased))

haven::write_dta(heart_failure, "data//heart_failure.dta")
haven::read_dta("data//heart_failure.dta") %>%
  mutate(anaemia = haven::as_factor(anaemia),
         diabetes = haven::as_factor(anaemia),
         sex = haven::as_factor(anaemia),
         smoking = haven::as_factor(anaemia),
         hypertension = haven::as_factor(hypertension),
         deceased = haven::as_factor(deceased))
