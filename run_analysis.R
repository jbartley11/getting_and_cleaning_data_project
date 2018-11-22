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

# read features data
features <- read.table( "./UCI HAR Dataset/features.txt")

# bind rows
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# name columns
names(y) <- c("label")
names(x) <- features$V2
names(subject) <- c("subject")

# bind columns to form one dataset
data <- cbind(subject, x, y)

# clear out unnecessary variables
rm(x_train, y_train, subject_train,
          x_test, y_test, subject_test,
          x, y, subject)


# 2. Extract only the mean and standard deviation measurements

# use regex to find mean and std measurements, keep labels and subject too
keep_columns <- grepl("mean|std|label|subject", names(data))

# use logical vector to return only the columns needed
data <- data[, keep_columns]


# 3. Use descriptive activity names to name the activities in the data set

# read activities
activities <- read.table( "./UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("label", "activity")

data$label <- factor(data$label, activities$label, activities$activity)
