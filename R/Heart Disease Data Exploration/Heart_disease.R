# Loading Data
data<-read.csv("heart_2020_cleaned.csv")

# Count missing observations
sapply(data, function(x)(sum(is.na(x)))) # NA counts

# DATA CLEANING AND PREPARATION
#########
names(data)[c(4)] <- c("Alcohol") 
names(data)[c(8)] <- c("DifficultyWalking") 

# Factorizing categorical variables
data$HeartDisease <- as.factor(data$HeartDisease)
data$Smoking <- as.factor(data$Smoking)
data$Alcohol <- as.factor(data$Alcohol)
data$Stroke <- as.factor(data$Stroke)
data$DifficultyWalking <- as.factor(data$DifficultyWalking)
data$Sex <- as.factor(data$Sex)
data$AgeCategory <- as.factor(data$AgeCategory)
data$Race <- as.factor(data$Race)
data$Diabetic <- as.factor(data$Diabetic)
data$PhysicalActivity <- as.factor(data$PhysicalActivity)
data$GenHealth <- as.factor(data$GenHealth) 
data$Asthma <- as.factor(data$Asthma)
data$KidneyDisease <- as.factor(data$KidneyDisease)
data$SkinCancer <- as.factor(data$SkinCancer)

summary(data)

# Small fixes

# Ordering the health levels from "Poor" to "Excellent"
data$GenHealth <- ordered(data$GenHealth, levels = c("Poor", "Fair", "Good","Very good","Excellent"))
# Ordering the age categories
data$AgeCategory <- ordered(data$AgeCategory)
# Renaming the levels for Diabetic and Race columns
data$Diabetic <- factor(data$Diabetic,labels =  c("No","Borderline","Yes","During pregnancy"))
data$Race <- factor(data$Race,labels =  c("American/Alaskan natives","Asian",
                                          "Black","Hispanic", "Other", "White"))

# The boxplot for the average hours of sleep during all the 24h  shows some weird 
# outliers like people that declared to sleep, on average, 1h or even 24h.
# Maybe some patients didn't read that it was asked the average hours of sleep
# in 24h period and just wrote how many hours they slept the day before or they
# only considered the hours of sleep during night and not also during day
boxplot(data$SleepTime,main="Hours of sleep",horizontal=TRUE)


# For this reason, we removed patients that declared to sleep on average less than 3 or
# more than 18 hours, as it seems very implausible. 
Data <- subset(data, data$SleepTime >= 3 & data$SleepTime <= 18)
# Now we have very few outliers but they are reasonable
boxplot(Data$SleepTime,main="Hours of sleep",horizontal=TRUE)

# We have removed only 1450 rows
dim(data)[1] - dim(Data)[1]  

# Dataset is now cleaned
summary(Data)
###########

# PLOTS
###########
library(ggplot2)
library(scales)
library(dplyr)

# Plot of BMI w.r.t Heart Disease. 
# People with heart disease tends to have slightly higher BMI on average
ggplot(data, aes(x = BMI)) + 
  geom_histogram(binwidth=2, color="black", fill="blue", alpha=0.7, position = 'identity') +
  scale_x_continuous(breaks = seq(10, 95, 5)) +
  scale_y_continuous(breaks = seq(0, 60000, 5000)) +
  labs(x = "BMI", y = "", title = "Body Mass Index")

ggplot(data, aes(x = BMI)) + 
  geom_boxplot(color="black", fill="blue", alpha  = .7, fatten = .7, outlier.colour="red") + 
  scale_x_continuous(breaks = seq(10, 95, 5)) +
  labs(x = "BMI", title = " Body Mass Index") +
  theme(axis.text.y  = element_blank(), axis.ticks.y = element_blank()) 

# Plot of Physical Health w.r.t Heart Disease. 
# It suggests that the probability to have an heart disease increases 
# with the number of days with poor physical health
ggplot(Data, aes(y = PhysicalHealth, fill = HeartDisease)) +
  geom_boxplot(color="black", alpha  = .7, fatten = .7) +
  labs(x = "", y = "Days", title = "Poor Physical Health in the last 30 day") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease",
                     labels = c("No HD", "Has HD")) + 
  theme(axis.text.x  = element_blank(),axis.ticks.x = element_blank())

# temp is a temporary dataframe used for the percentage plots
temp = Data %>% group_by(PhysicalHealth) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 
temp = temp[seq(2, nrow(temp), by = 2) , ]

ggplot(temp, aes(x = PhysicalHealth, y = pct)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8, 
           fill = "red") +
  scale_x_continuous(breaks = seq(0, 30, 1)) +
  scale_y_continuous(breaks = seq(0, 30, 3)) +
  labs(x = "Days", y = "Percentage",) +
  ggtitle("Poor Physical Health in the last 30 day %")

# Plot of Mental Health w.r.t Heart Disease. 
# It seems there is a very weak relationship between the two variables since
# the probability to have a heart disease tends to slightly increase
# as the number of days with poor mental health increase
ggplot(Data, aes(y = MentalHealth, fill = HeartDisease)) +
  geom_boxplot(color="black", alpha  = .7, fatten = .7) +
  labs(x = "", y = "Days", title = "Poor Mental Health in the last 30 day") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease",
                     labels = c("No HD", "Has HD")) + 
  theme(axis.text.x  = element_blank(),axis.ticks.x = element_blank())

temp = Data %>% group_by(MentalHealth) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 
temp = temp[seq(2, nrow(temp), by = 2) , ]

ggplot(temp, aes(x = MentalHealth, y = pct)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8, 
           fill = "red") +
  scale_x_continuous(breaks = seq(0, 30, 1)) +
  scale_y_continuous(breaks = seq(0, 30, 2)) +
  labs(x = "Days", y = "Percentage",) +
  ggtitle("Poor Mental Health in the last 30 day %")

# Plot of Sleep Time w.r.t Heart Disease. 
# It seems is slightly more likely to get an heart disease in the 12h area, and 4/16h
ggplot(Data, aes(SleepTime, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_x_continuous(breaks = seq(3, 18, 1)) +
  scale_y_continuous(breaks = seq(0, 100000, 10000)) +
  labs(x = "SleepTime", y = "", title = "Average Hours of Sleep in 24h") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp = Data %>% group_by(SleepTime) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 
temp = temp[seq(2, nrow(temp), by = 2) , ]

ggplot(temp, aes(x = SleepTime, y = pct)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .9, 
           fill = "red") +
  scale_x_continuous(breaks = seq(3, 18, 1)) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "SleepTime", y = "Percentage",) +
  ggtitle("Average Hours of Sleep in 24h %")

# Plot of Smoking w.r.t Heart Disease. 
# It seems there is a weak relationship as we almost double the probability
# to have a heart disease, going from 6.02% to 12.11%
ggplot(Data, aes(Smoking, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 200000, 20000)) +
  labs(x = "Smoking", y = "", title = "Smoked at least 100 cigarettes") +
  scale_fill_manual( values = c("green", "red"), 
                     labels = c("No HD", "Has HD"))

temp <- Data %>% group_by(Smoking) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100)

ggplot(temp, aes(x = Smoking, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 10) +
  labs(x = "Smoking", y = "Percentage") +
  ggtitle("Smoked at least 100 cigarettes %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Alcohol w.r.t Heart Disease. 
# Doesn't seem to be any relation between the 2 variables. Actually it seems to
# reduce the probability to have an heart disease since we have 5.21% against 8.77%
ggplot(Data, aes(Alcohol, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", 
           color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 25000)) +
  labs(x = "Alcohol", y = "", title = "Heavy Drinkers") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD")) 

temp <- Data %>% group_by(Alcohol) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100)

ggplot(temp, aes(x = Alcohol, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 10) +
  labs(x = "Alcohol", y = "Percentage") +
  ggtitle("Heavy Drinkers %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Stroke w.r.t Heart Disease. 
# As expected, there's a strong relationship as 36,16% of the people that had at 
# least one stroke also have a heart disease, against only 7,45%
ggplot(Data, aes(Stroke, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 25000)) +
  labs(x = "Stroke", y = "", title = "At least one Stroke") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

temp <- Data %>% group_by(Stroke) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = Stroke, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 10) +
  labs(x = "Stroke", y = "Percentage",) +
  ggtitle("Stroke %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Difficulty Walking w.r.t Heart Disease. 
# Also here it seems there is a relationship between the 2 variables as we have
# 22.49% against 6.29%
ggplot(Data, aes(DifficultyWalking, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 25000)) +
  labs(x = "DifficultyWalking", y = "", title = "Having difficulty walking or climbing stairs") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD")) 

temp <- Data %>% group_by(DifficultyWalking) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100)

ggplot(temp, aes(x = DifficultyWalking, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 10) +
  labs(x = "Difficulty Walking", y = "Percentage") +
  ggtitle("Having difficulty walking or climbing stairs %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Sex w.r.t Heart Disease. 
# Males seems to have slightly more probability to get a heart disease since
# they have 10.6% against 6.66%
ggplot(Data, aes(Sex, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 20000)) +
  labs(x = "Sex", y = "", title = "Males and Females") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD")) 

temp <- Data %>% group_by(Sex) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = Sex, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 10) +
  labs(x = "Sex", y = "Percentage",) +
  ggtitle("Males and Females %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Age Categories w.r.t Heart Disease. 
# As expected, the probability to have a heart disease increases with the age
ggplot(Data, aes(AgeCategory, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 30000, 2000)) +
  labs(x = "AgeCategory", y = "", title = "Age Categories") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp = Data %>% group_by(AgeCategory) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 
temp = temp[seq(2, nrow(temp), by = 2) , ]

ggplot(temp, aes(x = AgeCategory, y = pct)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8, 
           fill = "red") +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 4.5) +
  labs(x = "AgeCategory", y = "Percentage",) +
  ggtitle("Age Categories %")

# Plot of Race w.r.t Heart Disease. 
# Apparently, American/Alaskan natives seems to have slightly higher 
# chance of getting a heart diseases while Asians are less likely
ggplot(Data, aes(Race, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 30000)) +
  labs(x = "Race", y = "", title = "Races") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(Race) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = Race, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5), size = 7) +
  labs(x = "Race", y = "Percentage",) +
  ggtitle("Races %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD")) 

# Plot of Diabetic w.r.t Heart Disease. 
# Diabetic people seems to have higher chance of having heart disease since
# they have 21.9% against 6.48%, with 11.55% if borderline and 4.16% if the 
# patient was diabetic during pregnancy
ggplot(Data, aes(Diabetic, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 25000)) +
  labs(x = "Diabetic", y = "", title = "Having Diabetes") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(Diabetic) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = Diabetic, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "Diabetic", y = "Percentage",) +
  ggtitle("Having Diabetes %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Physical Activity w.r.t Heart Disease. 
# It seems that people that don't do physical activities regularly are almost
# 2 times more likely to have a heart disease since they have 13.7% against
# 7.03%
ggplot(Data, aes(PhysicalActivity, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 25000)) +
  labs(x = "PhysicalActivity", y = "", title = "Physical activity during the last 30 days") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(PhysicalActivity) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = PhysicalActivity, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "PhysicalActivity", y = "Percentage",) +
  ggtitle("Physical Activity %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of General Health w.r.t Heart Disease. 
# It seems there is a relationship,as people with poor or fair health are
# more likely to have heart disease
ggplot(Data, aes(GenHealth, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 150000, 10000)) +
  labs(x = "GenHealth", y = "", title = "General Health") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp = Data %>% group_by(GenHealth) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 
temp = temp[seq(2, nrow(temp), by = 2) , ]

ggplot(temp, aes(x = GenHealth, y = pct)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8, 
           fill = "red") +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "GenHealth", y = "Percentage",) +
  ggtitle("General Health %")

# Plot of Asthma w.r.t Heart Disease. 
# It seems there is a weak relationship since people without asthma have 8.09%
# while people with asthma have 11.42% of having a heart disease
ggplot(Data, aes(Asthma, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 250000, 30000)) +
  labs(x = "Asthma", y = "", title = "Having Asthma") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(Asthma) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = Asthma, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "Asthma", y = "Percentage",) +
  ggtitle("Asthma %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Kidney Disease w.r.t Heart Disease. 
# There is strong relationship as 29,26% of the people with kidney disease also
# have heart disease, against only 7.74%. 
ggplot(Data, aes(KidneyDisease, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 30000)) +
  labs(x = "KidneyDisease", y = "", title = "Having Kidney Disease") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(KidneyDisease) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = KidneyDisease, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "KidneyDisease", y = "Percentage",) +
  ggtitle("Having Kidney Disease %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Plot of Skin Cancer w.r.t Heart Disease. 
# It seems there is a relationship between the 2 variables since people
# with skin cancer are more than 2 times more likely to have a hear disease,
# going from 7.7% to 16.66%
ggplot(Data, aes(SkinCancer, fill = HeartDisease)) + 
  geom_bar(alpha  = .7,position = "dodge", color = "black", width = .8) + 
  scale_y_continuous(breaks = seq(0, 280000, 30000)) +
  labs(x = "SkinCancer", y = "", title = "Having Skin Cancer") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Yes HD"))

temp <- Data %>% group_by(SkinCancer) %>% count(HeartDisease) %>% mutate(pct = n / sum(n)*100) 

ggplot(temp, aes(x = SkinCancer, y = pct, fill = HeartDisease)) +
  geom_bar(stat = "identity",  alpha  = .7, color = "black", width = .8) +
  geom_text(aes(label = paste(round(pct, 2),"%"), y = pct), 
            position = position_stack(vjust = 0.5)) +
  labs(x = "SkinCancer", y = "Percentage",) +
  ggtitle("Having Skin Cancer %") +
  scale_fill_manual( values = c("green", "red"), name = "Heart\nDisease", 
                     labels = c("No HD", "Has HD"))

# Correlation and Covariance matrices of the numerical variables
cor(Data[,c("BMI","PhysicalHealth","MentalHealth","SleepTime")])
cov(Data[,c("BMI","PhysicalHealth","MentalHealth","SleepTime")])
