##################################
#       Susanna Koivusaari       #
#           2023/11/13           #
#            IODS 2023           # 
#  Assignment 3: Data wrangling  #
##################################


# Data used in this exercise can be found here: http://archive.ics.uci.edu/dataset/320/student+performance



### Task 1. ###

# Go to the UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page here. 
# Then choose "Download" to download the .zip file. Unzip the file and move the two .csv files (student-mat.csv) 
# and (student-por.csv) to the data folder in your course project folder.



### Task 2. ###

# Create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on 
# the top of the script (include a reference to the data source). Save the script as 'create_alc.R' in the ‘data’ 
# folder of your project. Complete the rest of the steps in that script.



### Task 3. ###

# Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and 
# dimensions of the data. 


# read in data 
mat <- read.csv("C:/Users/koivusus/IODS/IODS-project_new/data/student-mat.csv", sep = ";")
por <- read.csv("C:/Users/koivusus/IODS/IODS-project_new/data/student-por.csv", sep = ";")


# explore structure 
str(mat)
str(por)


# explore dimensions
dim(mat)
dim(por)


### Task 4. ###

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as 
# (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions 
# of the joined data. 


# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")


# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)


# join the two data sets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))


# see how the absences cols look like 
table(mat_por$absences.mat)
table(mat_por$absences.por)


# keep students with zero absences in both datasets 
mat_por_fil <- filter(mat_por, absences.mat == 0 & absences.por == 0)


# explore structure 
str(mat_por_fil)


# explore dimensions
dim(mat_por_fil)



### Task 5. ###

# Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise 
# "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, or b) write your own 
# solution to achieve this task. 


# create a new data frame with only the joined columns
alc <- select(mat_por, all_of(join_cols))


# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(mat_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}



### Task 6. ###

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' 
# to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 
# 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)


# take the average of answers related to weekday an weekend alc consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)


# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)



### Task 7. ###

# Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 
# 370 observations. Save the joined and modified data set to the ‘data’ folder, using for example write_csv() 
# function (readr package, part of tidyverse). 


# glimpse at the joined and modified data 
glimpse(alc)


# save the data 
write.csv(alc, "C:/Users/koivusus/IODS/IODS-project_new/data/alc.csv")


