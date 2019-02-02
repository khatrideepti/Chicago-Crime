library(plyr)
crimeData <- read.csv("C:/Users/preet/Desktop/Rutgers-2nd sem/Chicago_Crimes_2012_to_2017.csv", stringsAsFactors=FALSE)
crime_remove2017<-crimeData[!(crimeData$Year == "2017"),]
crime = crime_remove2017
setNames(count(crime, "Year"), c("Category", "Volume"))
str(crime)
#Aggregating Primary type
class(crime$Primary.Type)
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('ASSAULT', 'THEFT', 'ROBBERY', 'HUMAN TRAFFICKING', 'BURGLARY', 'WEAPONS VIOLATION')] <- "Serious-Offenses"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('DECEPTIVE PRACTICE','LIQUOR LAW VIOLATION','PROSTITUTION','GAMBLING','INTERFERENCE WITH PUBLIC OFFICER')] <- "Less Serious-Offenses"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('OFFENSE INVOLVING CHILDREN','HOMICIDE','INTIMIDATION','CONCEALED CARRY LICENSE VIOLATION','KIDNAPPING','BATTERY')] <- "Violent Crimes"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('PUBLIC PEACE VIOLATION','CRIMINAL TRESPASS','STALKING','CRIMINAL DAMAGE','ARSON','PUBLIC INDECENCY')] <- "Public Violence"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('SEX OFFENSE','CRIM SEXUAL ASSAULT')] <- "Criminal Sexual Assault"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('MOTOR VEHICLE THEFT')] <- "Motor Vehicle theft"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('OTHER OFFENSE','NON - CRIMINAL','NON-CRIMINAL (SUBJECT SPECIFIED)','OBSCENITY','NON-CRIMINAL')] <- "Non-Criminal"
crime$Aggregated_PrimaryType[crime$Primary.Type %in% c('NARCOTICS','OTHER NARCOTIC VIOLATION')] <- "Drug/Narcotic Violation"
crime$Aggregated_PrimaryType = as.factor(crime$Aggregated_PrimaryType)
head(crime$Aggregated_PrimaryType)
setNames(count(crime, "Aggregated_PrimaryType"), c("Category", "Volume"))
#Finding number of na's or ""
colSums(is.na(crime))
colSums(crime == "")
crime = crime[!(((is.na(crime$Latitude)) && !(is.na(crime$Longitude))) | crime$Location == ""),]
#Feature Extraction 1 - crime_categories
crime$crime_categories = NA
crime$crime_categories[crime$Primary.Type %in% c('ASSAULT' , 'ROBBERY' , 'BATTERY' , 'WEAPONS VIOLATION', 'SEX OFFENSE', 'OFFENSE INVOLVING CHILDREN','CRIM SEXUAL ASSAULT','KIDNAPPING','HOMICIDE' ,'HUMAN TRAFFICKING','INTIMIDATION', 'CONCEALED CARRY LICENSE VIOLATION')] <- 'Violence'
crime$crime_categories[crime$Primary.Type %in% c('ARSON','BURGLARY','CRIMINAL DAMAGE','CRIMINAL TRESPASS','DECEPTIVE PRACTICE','GAMBLING','INTERFERENCE WITH PUBLIC OFFICER', 'LIQUOR LAW VIOLATION','MOTOR VEHICLE THEFT','NARCOTICS','NON-CRIMINAL','NON-CRIMINAL (SUBJECT SPECIFIED)','NON - CRIMINAL','OBSCENITY','OTHER NARCOTIC VIOLATION','OTHER OFFENSE','PROSTITUTION','PUBLIC INDECENCY','PUBLIC PEACE VIOLATION','STALKING','THEFT')] <- 'Non-violence'
head(crime$crime_categories)
#Feature Extraction 2 - loc_categories
crime$loc_categories[crime$Location.Description %in% c('SIDEWALK','STREET','ALLEY','HIGHWAY/EXPRESSWAY','EXPRESSWAY EMBANKMENT','CHA HALLWAY/STAIRWELL/ELEVATOR','BOWLING ALLEY','HALLWAY','STAIRWELL','VESTIBULE','DRIVEWAY','ELEVATOR','GANGWAY','BRIDGE')] <- "PATHWAYS"
crime$loc_categories[crime$Location.Description %in% c('APARTMENT','CHA APARTMENT','RESIDENCE','RESIDENCE PORCH/HALLWAY','RESIDENTIAL YARD (FRONT/BACK)','YARD','RESIDENCE-GARAGE','GARAGE','DRIVEWAY - RESIDENTIAL','ABANDONED BUILDING','NURSING HOME/RETIREMENT HOME','NURSING HOME','ROOMING HOUSE','PORCH','FEDERAL BUILDING','HOUSE')] <- "RESIDENTIAL PLACES"
crime$loc_categories[crime$Location.Description %in% c('POLICE FACILITY/VEH PARKING LOT','CHA PARKING LOT/GROUNDS','PARKING LOT','PARKING LOT/GARAGE(NON.RESID.)','CHA PARKING LOT')] <- "PARKING LOTS"
crime$loc_categories[crime$Location.Description %in% c('BAR OR TAVERN','CLUB','TAVERN')] <- "CLUB,BAR AND TAVERN"
crime$loc_categories[crime$Location.Description %in% c('CTA TRAIN','CTA PLATFORM','CTA BUS','CHICAGO TRANSIT AUTHORITY','CTA STATION','CTA GARAGE / OTHER PROPERTY','CTA BUS STOP','CTA TRACKS - RIGHT OF WAY','CTA "L" PLATFORM','CTA PROPERTY','CTA "L" TRAIN','CHA HALLWAY')] <- "CHICAGO TRANSIT AUTHORITY"
crime$loc_categories[crime$Location.Description %in% c('VEHICLE NON-COMMERCIAL','OTHER COMMERCIAL TRANSPORTATION','VEHICLE-COMMERCIAL','VEHICLE - DELIVERY TRUCK','TRUCK','DELIVERY TRUCK','VEHICLE - OTHER RIDE SERVICE')] <- "VEHICLE SERVICES"
crime$loc_categories[crime$Location.Description %in% c('SCHOOL, PUBLIC, GROUNDS','PARK PROPERTY','VACANT LOT/LAND','VACANT LOT','FACTORY/MANUFACTURING BUILDING','WAREHOUSE','CONSTRUCTION SITE','COLLEGE/UNIVERSITY GROUNDS','SCHOOL, PUBLIC, BUILDING','SCHOOL, PRIVATE, GROUNDS','COLLEGE/UNIVERSITY RESIDENCE HALL','SCHOOL, PRIVATE, BUILDING','SCHOOL YARD')] <- "SCHOOLS AND BUILDINGS (PUBLIC AND PRIVATE AREAS)"
crime$loc_categories[crime$Location.Description %in% c('RESTAURANT','HOTEL/MOTEL','HOTEL')] <- "HOTEL/MOTEL AND RESTAURANT"
crime$loc_categories[crime$Location.Description %in% c('BANK','CREDIT UNION','SAVINGS AND LOAN')] <- "BANK"
crime$loc_categories[crime$Location.Description %in% c('MEDICAL/DENTAL OFFICE','COMMERCIAL / BUSINESS OFFICE','OFFICE')] <- "COMMERCIAL AND OTHER OFFICES"
crime$loc_categories[crime$Location.Description %in% c('HOSPITAL BUILDING/GROUNDS','ANIMAL HOSPITAL','HOSPITAL')] <- "HOSPITALS"
crime$loc_categories[crime$Location.Description %in% c('SMALL RETAIL STORE','DRUG STORE','GROCERY FOOD STORE','CONVENIENCE STORE','TAVERN/LIQUOR STORE','DEPARTMENT STORE','PAWN SHOP','APPLIANCE STORE','CLEANING STORE','RETAIL STORE','LIQUOR STORE')] <- "VARIOUS STORES"
crime$loc_categories[crime$Location.Description %in% c('SPORTS ARENA/STADIUM','ATHLETIC CLUB')] <- "SPORT CLUBS"
crime$loc_categories[crime$Location.Description %in% c('AIRPORT/AIRCRAFT','AIRPORT TERMINAL LOWER LEVEL - NON-SECURE AREA','AIRPORT TERMINAL UPPER LEVEL - NON-SECURE AREA','AIRPORT EXTERIOR - NON-SECURE AREA','AIRPORT BUILDING NON-TERMINAL - NON-SECURE AREA','AIRPORT BUILDING NON-TERMINAL - SECURE AREA','AIRPORT PARKING LOT','AIRPORT VENDING ESTABLISHMENT','AIRPORT TERMINAL MEZZANINE - NON-SECURE AREA','AIRPORT TERMINAL LOWER LEVEL - SECURE AREA','AIRPORT EXTERIOR - SECURE AREA','AIRPORT TERMINAL UPPER LEVEL - NON-SECURE AREA','AIRPORT TRANSPORTATION SYSTEM (ATS)','AIRPORT TERMINAL UPPER LEVEL - SECURE AREA','AIRCRAFT')] <- "AIRPORT"
crime$loc_categories[crime$Location.Description %in% c('GAS STATION','FIRE STATION','GAS STATION DRIVE/PROP.')] <- "GAS AND FIRE STATIONS"
crime$loc_categories[crime$Location.Description %in% c('GOVERNMENT BUILDING','GOVERNMENT BUILDING/PROPERTY','RIVER BANK','OTHER RAILROAD PROP / TRAIN DEPOT','LAKEFRONT/WATERFRONT/RIVERBANK','JAIL / LOCK-UP FACILITY','FOREST PRESERVE','CHURCH/SYNAGOGUE/PLACE OF WORSHIP','CHURCH','RAILROAD PROPERTY')] <- "GOVERNMENT PROPERTY"
crime$loc_categories[crime$Location.Description %in% c('LIBRARY','TAXICAB','BARBERSHOP','ATM (AUTOMATIC TELLER MACHINE)','CURRENCY EXCHANGE','DAY CARE CENTER','MOVIE HOUSE/THEATER','CAR WASH','POOL ROOM','POOLROOM','AUTO','OTHER','FIRE STATION','BOAT/WATERCRAFT','BARBER SHOP/BEAUTY SALON','CEMETARY','NEWSSTAND','CLEANERS/LAUNDROMAT','COIN OPERATED MACHINE','BASEMENT','LAUNDRY ROOM','LAGOON','OTHERS','AUTO / BOAT / RV DEALERSHIP')] <- "OTHERS"
crime$loc_categories = as.factor(crime$loc_categories)
head(crime$loc_categories)


#Change ID to char
crime$ID=as.character(crime$ID)
#Primary type to fator
crime$Primary.Type = as.factor(crime$Primary.Type )
#Arrest to Boolean
crime$Arrest= as.logical(crime$Arrest)
#Domestic to Boolean 
crime$Domestic=as.logical(crime$Domestic)
#FBI code to factor
crime$FBI.Code= as.factor(crime$FBI.Code)
#Year to factor
crime$Year=as.factor(crime$Year)
#crime_categories to factor
crime$crime_categories=as.factor(crime$crime_categories)
crime$Date=as.POSIXlt(crime$Date,format="%m/%d/%Y %I:%M:%S %p")

#Time as Strings
crime$Crimehour=crime$Date$hour
crime$Crimehour = as.numeric(crime$Crimehour)
crime$timegroup <- with(crime,  ifelse(Crimehour >= 6 & Crimehour<12, "morning",ifelse(Crimehour >= 12 & Crimehour<18, "afternoon",ifelse(Crimehour>18 & Crimehour<24, "evening", "night"))))
crime$timegroup = as.factor(crime$timegroup)

#Feature Selection
crime_new = crime[(c("Block","Primary.Type","Arrest","Domestic","Beat","District","Ward","Community.Area","Year","Latitude","Longitude","crime_categories","loc_categories","Date","Crimehour","timegroup"))]
#Considering data only for top 5 crimes
top5Crimes = c('THEFT','NARCOTICS','BATTERY','CRIMINAL DAMAGE','ASSAULT')
crime_newFiltered = crime_new[crime_new$Primary.Type %in% top5Crimes,]
#drop unused levels
crime_newFiltered$Primary.Type = droplevels(crime_newFiltered$Primary.Type)
crime2 = na.omit(crime_newFiltered,cols = c("Community.Area","District","ward","loc_categories"))

# Random Forest
library(randomForest)
library(caret)
set.seed(100)
crimeSample <- sample(nrow(crime2),as.integer(nrow(crime2)*0.03))
crimeSample2 = crime2[crimeSample,]
train=sample(nrow(crimeSample2),as.integer(nrow(crimeSample2)*0.7))
TrainSet = crimeSample2[train,]
TestSet = crimeSample2[-train,]

#Tuning to use best mtry and ntree

num_try = 5
num_obs = nrow(crime4)
ntree = c(50,101,120,200,300,500,600,650,1000)
for (i in 1:length(ntree)) {
  val_err = rep(0, num_try)
  for (j in 1:num_try) {
    set.seed(j)
    train1 = sample(num_obs, as.integer(num_obs*0.01))
    crime_RFFit1 = randomForest(Primary.Type ~ .- Date - Crimehour - Block, data=crime4, subset=train1, mtry=4, ntree=ntree[i])
    bag.pred = predict(crime_RFFit1, newdata=crime4[-train1,])
    val_err[j] = mean(bag.pred != crime4[-train1,]$Primary.Type)
  }
  print(c(ntree[i],mean(val_err)))
}
crime_RFFit <- randomForest(Primary.Type ~ .- Date - Crimehour - Block, data = TrainSet,ntree=600,mtry=4, importance = TRUE)
varImpPlot(crime_RFFit)
pred = predict(crime_RFFit,TestSet)
confusionMatrix(data=pred,reference=TestSet$Primary.Type,positive='yes')

#Multinomial Logistic Regression
multinom.model <- multinom(Primary.Type ~ .- Date - Crimehour - Block, data = TrainSet,maxit = 500)
pred = predict(multinom.model,TestSet)
confusionMatrix(data=pred,reference=TestSet$Primary.Type,positive='yes')

#SVM
require(e1071)
svm.model = svm(Primary.Type ~ .- Date - Crimehour - Block, data = TrainSet)
pred = predict(svm.model,TestSet)
confusionMatrix(data=pred,reference=TestSet$Primary.Type,positive='yes')

#Plots
library('RColorBrewer')
ggplot(data = TrainSet, aes(x = timegroup, y = loc_categories)) +
geom_tile(aes(fill = Primary.Type)) +
scale_fill_brewer(palette="Spectral")

qplot(timegroup, data=TrainSet, geom="density", fill=Primary.Type, alpha=I(.5),
main="Top 5 Crimes Distribution", xlab="Time of the Day",
ylab="Density")

#Spatial Analysis - Leaflet
library(tidyverse)
library(leaflet)
library(stringr)
library(sf)
library(magrittr)

options(digits = 3)
set.seed(1234)
theme_set(theme_minimal())
crimes <- read.csv("C:/Users/sanket.DESKTOP-VJNS8K1/Documents/Rutgers Assignments/DAV/cleaned data/chicago_crime_cleaned_subset.csv")

(serious_offenses <- crimes %>%
    filter(`Aggregated_PrimaryType` == "Violent Crimes"))

serious_offenses %>%
  mutate(popup = str_c(Date,
                       Block,
                       str_c("Primary type:", `Primary.Type`,
                             sep = " "),
                       str_c("Location type:", `Location.Description`,
                             sep = " "),
                       sep = "<br/>")) %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions(),popup = ~popup)
