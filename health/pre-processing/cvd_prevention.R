# Cardiovascular Disease prevalence
# Source: NHS Digital ; House of Commons Library
# URL: https://commonslibrary.parliament.uk/social-policy/health/constituency-data-how-healthy-is-your-area

library(tidyverse) ; library(readxl) ; library(httr)

tmp <- tempfile(fileext = ".xlsx")
GET(url = "https://data.parliament.uk/resources/constituencystatistics/HealthDiseasePrevalence.xlsx",
    write_disk(tmp))

df <- read_xlsx(tmp,sheet = 4) %>%
  filter(grepl("Trafford",LA)) %>%
  mutate(indicator="Cardiovascular Disease prevalence",period="2018",measure="percentage",unit="persons", value=round(`Cardiovascular Disease (Primary Prevention)`*100,2)) %>%
  select(area_code="Row Labels", area_name="MSOA", indicator, period, measure, unit, value) %>%
  arrange(area_code)

write_csv(df, "cvd_prevalence.csv") 
