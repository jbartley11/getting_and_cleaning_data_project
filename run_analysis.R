# run_analysis.R
# create a tidy dataset using accelerometer data from Galaxy S

# load dplyr
library(dplyr)

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

# read features data
features <- read.table( "./UCI HAR Dataset/features.txt")

# bind rows
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# name columns
names(y) <- c("Activity")
names(x) <- features$V2
names(subject) <- c("Subject")

# bind columns to form one dataset
data <- cbind(subject, x, y)

# clear out unnecessary variables
rm(x_train, y_train, subject_train,
          x_test, y_test, subject_test,
          x, y, subject, features)

# 2. Extract only the mean and standard deviation measurements

# use regex to find mean and std measurements, keep labels and subject too
keep_columns <- grepl("mean|std|Activity|Subject", names(data))

# use logical vector to return only the columns needed
data <- data[, keep_columns]

# 3. Use descriptive activity names to name the activities in the data set

# read activities
activities <- read.table( "./UCI HAR Dataset/activity_labels.txt")

# set column names for activities
names(activities) <- c("Label", "Activity")

# set label column as factor
data$Activity <- factor(data$Activity, activities$Label, activities$Activity)

# 4. Appropriately label the data set with descriptive variable names

# get column names
column_names <- names(data)

# clean up column text
column_names <- gsub("^t", "Time", column_names)
column_names <- gsub("^f", "Frequency", column_names)
column_names <- gsub("mean", "Mean", column_names)
column_names <- gsub("std", "Std", column_names)
column_names <- gsub("BodyBody", "Body", column_names)

# remove dash and parentheses
column_names <- gsub("[()-]", "", column_names)

# set column names
names(data) <- column_names


# 5. Create a second, independent tidy data set with the average
#    of each variable for each activity and each subject

# use dplyr to group and summarize
data_summarized <- data %>% 
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

# export
write.table(data_summarized, "tidy_data.txt", row.name=FALSE)
