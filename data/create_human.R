##################################
#       Susanna Koivusaari       #
#           2023/11/20           #
#            IODS 2023           # 
#  Assignment 4: Data wrangling  #
##################################


### Task 1. ###

# Create a new R script called create_human.R



### Task 2. ###

# Read in the “Human development” and “Gender inequality” data sets 


# load library
library(readr)


# read in gender inequality data 
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")


# read in human development data 
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")



### Task 3. ###

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. (1 point)


# inspect the datasets 
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)



### Task 4. ###

# Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)


# see colnames in gii 
colnames(gii)


# rename gii variables (use column numbers as the variable names are long and complicated)
gii <- rename(gii, 
              "gender_eq_rank" = 1, 
              # variable 2 is fine 
              "gender_eq_rate" = 3, 
              "mort_ratio" = 4, 
              "birth_rate" = 5, 
              "parliam_perc" = 6, 
              "edu_f" = 7, 
              "edu_m" = 8, 
              "labo_f" = 9, 
              "labo_m" = 10)


# see colnames in gii 
colnames(hd)


# rename hd variables 
hd <- rename(hd, 
             "hdi_rank" = 1, 
             # variable 2 is fine
             "hdi_index" = 3, 
             "exp_life" = 4, 
             "exp_educ" = 5, 
             "mean_educ" = 6, 
             "gni" = 7, 
             "gni_minus_hdi_rank" = 8) 



### Task 5. ###

# Mutate the “Gender inequality” data and create two new variables. The first new 
# variable should be the ratio of female and male populations with secondary education 
# in each country (i.e., Edu2.F / Edu2.M). The second new variable should be the ratio 
# of labor force participation of females and males in each country (i.e., Labo.F / Labo.M). (1 point)


# create new variables 
gii_mut <- mutate(gii, edu_ratio = edu_f / edu_m, labo_ratio = labo_f / labo_m)

  
  
### Task 6. ###

# Join together the two datasets using the variable Country as the identifier. Keep only 
# the countries in both data sets (Hint: inner join). The joined data should have 195 
# observations and 19 variables. Call the new joined data "human" and save it in your 
# data folder (use write_csv() function from the readr package). (1 point)


# join the datasets together 
human <- inner_join(hd, gii_mut, by = "Country")


# check the dimensions 
dim(human) # 195 rows and 19 cols as supposed to 

# save the data 
write.csv(human, "C:/Users/koivusus/IODS/IODS-project_new/data/human.csv")


