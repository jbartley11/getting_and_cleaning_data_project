# description

# set working directory
setwd("Development/courses/coursera_get_clean_data/getting_and_cleaning_data_project")

# 1. Merge the training and the test sets to create one data set

# read training data
x_train <- read.table( "./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table( "./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table( "./UCI HAR Dataset/train/subject_train.txt")

# read test data
x_test <- read.table( "./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table( "./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table( "./UCI HAR Dataset/test/subject_test.txt")

# merge data sets
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
