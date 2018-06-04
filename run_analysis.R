# download and unzip the file
tmpFile <- tempfile()
download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        tmpFile,
        mode = "wb"
)
unzip(tmpFile)
unlink(tmpFile)

# read in the training files
trainingSubjects <-
        read.table("UCI HAR Dataset\\train\\subject_train.txt")
trainingActivities <-
        read.table("UCI HAR Dataset\\train\\y_train.txt")
trainingData <- read.table("UCI HAR Dataset\\train\\X_train.txt")

# read in the test files
testSubjects <-
        read.table("UCI HAR Dataset\\test\\subject_test.txt")
testActivities <- read.table("UCI HAR Dataset\\test\\y_test.txt")
testData <- read.table("UCI HAR Dataset\\test\\X_test.txt")

# read in the activity ID and name
activityLabels <-
        read.table("UCI HAR Dataset\\activity_labels.txt")
colnames(activityLabels) <- c("activityID", "activityName")

# read in the features list
featuresList <-
        read.table("UCI HAR Dataset\\features.txt", as.is = TRUE)

# merge the training and test files
mergedActivityData <-
        rbind(
                cbind(trainingSubjects, trainingActivities, trainingData),
                cbind(testSubjects, testActivities, testData)
        )

# change the subject and activity column names
colnames(mergedActivityData) <-
        c("subject", "activity", featuresList[, 2])

# select the columns to keep (only those with mean or std plus the subject and activity)
std_mean_columns <-
        grepl("subject|activity|mean()|std()",
              colnames(mergedActivityData))

# remove all the other columns
mergedActivityData <- mergedActivityData[, std_mean_columns]

# change the activity ID from a number to a readable label
mergedActivityData$activity <-
        factor(mergedActivityData$activity,
               levels = activityLabels[, 1],
               labels = activityLabels[, 2])

# clean up column names
renameCols <- gsub("[\\(\\)-]", "", renameCols)
colnames(mergedActivityData) <- renameCols

# group and summarize the data
mergedActivityFinal <-
        mergedActivityData %>% group_by(subject, activity) %>% summarize_all(funs(mean))

# write out the final tidy data set
write.table(
        mergedActivityFinal,
        "ActivityDataTidy.txt",
        row.names = FALSE,
        quote = FALSE
)
