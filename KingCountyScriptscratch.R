library(readxl)
library(dplyr)
library(leaflet)
library(ggplot2)
library(lubridate)

King_County_Sheriff_s_Office_3 <- read_excel("King_County_Sheriff_s_Office-3.xls")
df <- King_County_Sheriff_s_Office_3

#Sort by City and create a table

df_cty_auburn <- df%>%
  group_by(incident_description)%>%
  filter(city == "AUBURN")%>%
  summarise(n = n())


#Correllation between assault and time of day?

# asslt <- df%>%
#   group_by(hour_of_day)%>%
#   filter(parent_incident_type == "Assault")%>%
#   summarise(n = n())
# 
# lm(n~hour_of_day, data = asslt)
# cor(asslt$n, asslt$hour_of_day)
# ggplot(asslt, aes()) + geom_point(aes(hour_of_day, n, colour = ifelse(n < 50, "red", "blue"))) + geom_smooth(aes(hour_of_day, n), method = "lm")

#Creat a function

# func_crime <- function(CRIME){
#   asslt2 <- df%>%
#     group_by(hour_of_day)%>%
#     filter(parent_incident_type == CRIME)%>%
#     summarise(n = n())
#   return(asslt2)
#     ggplot(asslt2, aes()) + geom_point(aes(hour_of_day, n, colour = ifelse(n < 50, "red", "blue"))) + geom_smooth(aes(hour_of_day, n), method = "lm")
# }
# func_crime('Breaking & Entering')
# 
#   


       