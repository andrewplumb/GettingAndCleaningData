library(reshape2)

# set wd to location of unzipped data
setwd("C:\\Users\\XBBLXKV\\Coursera\\GettingAndCleaningData\\UCI HAR Dataset")

# import data
features <- read.table('./features.txt', header = F)
activityLabels <- read.table('./activity_labels.txt', header = F)
subjectTrain <- read.table('./train/subject_train.txt', header = F)
XTrain <- read.table('./train/X_train.txt', header = F)
yTrain <- read.table('./train/y_train.txt', header = F)
subjectTest <- read.table('./test/subject_test.txt', header = F)
XTest <- read.table('./test/X_test.txt', header = F)
yTest <- read.table('./test/y_test.txt', header = F)

# name the columns for all data
colnames(activityLabels) <- c("activityID", "activityLabel")

colnames(subjectTrain) <- "subjectID"
colnames(subjectTest) <- "subjectID"

colnames(XTrain) <- features[,2]
colnames(yTrain) <- "activityID"

colnames(XTest) <- features[,2]
colnames(yTest) <- "activityID"

# combine all columns into train and test data
data.train <- cbind(yTrain, subjectTrain, XTrain)
data.test <- cbind(yTest, subjectTest, XTest)

#combine train and test data into a single dataset
data <- rbind(data.train, data.test)

#select only columns that include "activity", "subject", "mean", or "std"
columnNames <- colnames(data)
activityLogical <- grepl("activity..", columnNames)
subjectLogical <- grepl("subject..", columnNames)
meanLogical <- grepl("mean()..", columnNames)
stdLogical <- grepl("std()..", columnNames)

data <- data[activityLogical | subjectLogical | meanLogical | stdLogical]

# replace the activityID with the descriptive name of the activity
data <- select(merge(data, activityLabels, by="activityID", all.x = T), -activityID)

# create a data set with the averages of each variable for each activity and subject
data_melted <- melt(data, id = c("subjectID", "activityLabel"))
data_mean <- dcast(data_melted, subjectID + activityLabel ~ variable, mean)


write.table(data_mean, "data_mean.txt", row.name=FALSE)
