##################################
#       Susanna Koivusaari       #
#           2023/11/06           #
#            IODS 2023           # 
#  Assignment 2: Data wrangling  #
##################################


### Task 1. ###

# Create a folder named ‘data’ in your IODS-project folder. Then create a new R script with RStudio. 
# Write your name, date and a one sentence file description as a comment on the top of the script file. 
# Save the script for example as 'create_learning2014.R' in the ‘data’ folder. Complete the rest of the steps in that script.



### Task 2. ###


# Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R 
# (the separator is a tab ("\t") and the file includes a header) and explore the structure and dimensions of the data. 
# Write short code comments describing the output of these explorations.


# read in data 
learning_2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


# explore structure 
str(learning_2014) # This is a data.frame containing 183 observations of 60 variables. Variables are in both integer and character formats. 


# explore dimensions 
dim(learning_2014) # Again, 183 observations and 60 variables.



### Task 3. ###


# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions 
# in the learning2014 data, as defined in the Exercise Set and also on the bottom part of the following page 
# (only the top part of the page is in Finnish). http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt. 
# Scale all combination variables to the original scales (by taking the mean). Exclude observations where the exam points 
# variable is zero. (The data should then have 166 observations and 7 variables) 


# see column names 
colnames(learning_2014)


# load library
library(dplyr)


# combine questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# select columns based on the created vector and create a new scaled variable to the original data 
deep_columns <- select(learning_2014, one_of(deep_questions))
learning_2014$deep <- rowMeans(deep_columns)


# select columns based on the created vector and create a new scaled variable to the original data 
surface_columns <- select(learning_2014, one_of(surface_questions))
learning_2014$surf <- rowMeans(surface_columns)


# select columns based on the created vector and create a new scaled variable to the original data 
strategic_columns <- select(learning_2014, one_of(strategic_questions))
learning_2014$stra <- rowMeans(strategic_columns)
  

# see column names 
colnames(learning_2014)


# select the necessary columns and rename them accordingly
learning_2014_sel <- select(learning_2014, gender, age = Age, attitude = Attitude, deep, stra, surf, points = Points)


# see column names 
colnames(learning_2014_sel)


# see points variable 
print(learning_2014_sel$points)


# exclude observations where the exam points variable is zero
learning_2014_sel_fil <- filter(learning_2014_sel, points != 0)


# see points variable 
print(learning_2014_sel_fil$points) # zeros are gone 


# data has 166 observations and 7 variables
dim(learning_2014_sel_fil)



### Task 4. ###

# Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio). 
# Save the analysis dataset to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). 
# You can name the data set for example as learning2014.csv. See ?write_csv for help or search the web for pointers and examples. 
# Demonstrate that you can also read the data again by using read_csv(). (Use `str()` and `head()` to make sure that the structure of the data is correct). 


# set working directory 
setwd("C:/Users/koivusus/IODS/IODS-project_new")


# save the data as csv 
write.csv(learning_2014_sel_fil, "data/learning_2014_sel_fil.csv")


# read in the saved data 
data <- read.csv("data/learning_2014_sel_fil.csv")


# check that it looks ok 
str(data)
dim(data) # everything looks ok (ID column is added when data is read to R but it can be removed if necessary)


