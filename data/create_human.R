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

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. 


# inspect the datasets 
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)



### Task 4. ###

# Look at the meta files and rename the variables with (shorter) descriptive names.


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
# of labor force participation of females and males in each country (i.e., Labo.F / Labo.M). 


# create new variables 
gii_mut <- mutate(gii, edu_ratio = edu_f / edu_m, labo_ratio = labo_f / labo_m)

  
  
### Task 6. ###

# Join together the two datasets using the variable Country as the identifier. Keep only 
# the countries in both data sets (Hint: inner join). The joined data should have 195 
# observations and 19 variables. Call the new joined data "human" and save it in your 
# data folder (use write_csv() function from the readr package). 


# join the datasets together 
human <- inner_join(hd, gii_mut, by = "Country")


# check the dimensions 
dim(human) # 195 rows and 19 cols as supposed to 

# save the data 
write.csv(human, "C:/Users/koivusus/IODS/IODS-project_new/data/human.csv")



##################################
#       Susanna Koivusaari       #
#           2023/11/27           #
#            IODS 2023           # 
#  Assignment 5: Data wrangling  #
##################################


# Let's continue to wrangle the human data we started last week. 



### Task 1. ###

# Explore the structure and the dimensions of the 'human' data and describe the dataset briefly, 
# assuming the reader has no previous knowledge of it. 


# read in the data again
human <- read.csv("C:/Users/koivusus/IODS/IODS-project_new/data/human.csv")


# explore structure 
str(human)


# The data has 195 observations of 20 variables. The variables are in integer, numerical and character formats. 
# The data is called human development indices. Thus, it gives us different indices for human development for different countries.
# For instance, edu_ratio shows us the ratio of female and male populations with secondary education in each country. 



### Task 2. ###

# Exclude unneeded variables: keep only the columns matching the following variable names:  
# "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 


# define the columns to keep 
keep_cols <- c("Country", "edu_ratio", "labo_ratio", "exp_educ", "exp_life", "gni", "mort_ratio", "birth_rate", "parliam_perc")


# select the wanted columns
human_sel <- select(human, one_of(keep_cols))



### Task 3. ###

# Remove all rows with missing values.


# print out the data along with a completeness indicator as the last column
human_sel_comp <- data.frame(human_sel, comp = complete.cases(human_sel))
print(human_sel_comp[-1])


# filter out all rows with NA values
human_sel_comp_fil <- filter(human_sel_comp, comp == "TRUE") 


# check how many were deleted 
nrow(human_sel_comp) # 195
nrow(human_sel_comp_fil) # 162



### Task 4. ###

# Remove the observations which relate to regions instead of countries. 


# inspect the country column
print(human_sel_comp_fil$Country)


# remove regions
human_sel_comp_fil_countr <- filter(human_sel_comp_fil, Country != "Europe and Central Asia" & Country != "East Asia and the Pacific" 
                                    & Country != "Latin America and the Caribbean" & Country != "Sub-Saharan Africa" & Country != "Arab States"
                                    & Country != "World" & Country !="South Asia") 

# check that the filtering worked 
print(human_sel_comp_fil_countr$Country)



### Task 5. ###

# The data should now have 155 observations and 9 variables (including the "Country" variable). 
# Save the human data in your data folder. You can overwrite your old ‘human’ data. 


# inspect the data
dim(human_sel_comp_fil_countr) # 155 10 
head(human_sel_comp_fil_countr)


# remove the comp variable
human_final <- select(human_sel_comp_fil_countr, !comp)
dim(human_final) # 155 9


# save the data 
write.csv(human_final, "C:/Users/koivusus/IODS/IODS-project_new/data/human.csv")


