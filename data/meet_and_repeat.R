##################################
#       Susanna Koivusaari       #
#           2023/12/09           #
#            IODS 2023           # 
#  Assignment 6: Data wrangling  #
##################################


### Task 1. ###

# Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt
# As before, write the wrangled data sets to files in your IODS-project data-folder.

# Also, take a look at the data sets: check their variable names, view the data contents and structures, 
# and create some brief summaries of the variables, so that you understand the point of the wide form data. 


# read in data 
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)


# see variable names 
names(BPRS)
names(RATS)


# see structure
str(BPRS)
str(RATS)


# see summaries
summary(BPRS)
summary(RATS)



### Task 2. ###

# Convert the categorical variables of both data sets to factors. 


# convert categoricals to factors in BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)


# convert categoricals to factors in RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)



### Task 3. ###

# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.


# convert BPRS from wide to long 
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  mutate(week = as.integer(substr(weeks, 5, 6))) %>% 
  arrange(weeks) # order by weeks variable


# convert RATS from wide to long 
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "groups",
                      values_to = "wd") %>% 
  mutate(Time = as.integer(substr(groups, 3, 4))) %>%
  arrange(Time)



### Task 4. ###

# Now, take a serious look at the new data sets and compare them with their wide form versions: 
# Check the variable names, view the data contents and structures, and create some brief summaries of the variables. 
# Make sure that you understand the point of the long form data and the crucial difference between the wide and the 
# long forms before proceeding the to Analysis exercise.


# check variable names
names(BPRSL)
names(RATSL)


# see structure
str(BPRSL)
str(RATSL)


# see summaries 
summary(BPRSL)
summary(RATSL)


