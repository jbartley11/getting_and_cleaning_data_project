# Getting and Cleaning Data Project

## Purpose

Use the content from the course to collect, work with, and clean a data set. Project uses accelerometer data from a series of subjects that used a Samsung Galaxy S.

## Files included
- run_analysis.R: script that generates the tidy_data.txt file
- README.md: provides purpose and overview of project
- tidy_data.txt: the result of run_analysis.R
- codebook.md: provides details about the dataset

## Process Detail

The wearables data can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R performs these actions against the raw data:
- Reads the separate files for training and testing
- Merges the tables into one data set
- Reshapes the data to only include mean and standard deviation measurements
- Populates the activity as a character instead of an integer
- Renames the columns so they are descriptive
- Generates a tidy data set that contains the average of each activity and each subject.

