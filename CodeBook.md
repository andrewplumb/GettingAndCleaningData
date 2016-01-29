Variables:

features, activityLabels, subjectTrain, XTrain, yTrain, subjectTest, XTest, and yTest are direct imports of the data

data.train is a combination of all train data
data.test is a combination of all test data
data is a combination of data.train and data.test

columnNames is all column names from data to be used in subsetting the data

data_melted is a melting of data on subjectID and activityLabel
data_mean is the second, independent tidy data set with the average of each variable for each activity and each subject


Data:
The data is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Transformations:
train and test data are combined independently with cbind
train and test data are combined to create data with rbind

columns that include mean or std are selected using grepl

the activity id is replaced with the descriptive activity title using merge and select

the final data set is created using melt and dcast.
