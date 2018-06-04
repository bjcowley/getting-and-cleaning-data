# Getting and Cleaning Data - Course Project


I created an R script called run_analysis.R that does the following:
- Downloads a data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
- Extracts the various data files.
- Merges the training and the test files to create a single data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This new, tidy data set is out put as ActivityDataTidy.txt
