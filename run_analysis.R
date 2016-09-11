## 8-Sep-2016
## Paul Kavitz
## Programming Assignment for Course 3, "Getting and Cleaning Data"
##

## Requirements for this script include:
##   1. Merges the training and the test sets to create one data set
##   2. Extracts only the measurements on the mean and standard deviation
##      for each measurement
##   3. Uses descriptive activity names to name the activities in the
##      data set
##   4. Appropriately labels the data set with descriptive variable names.
##   5. From the data set in step 4, creates a second, independent tidy data
##      set with the average of each variable for each activity and each
##      subject.
##

## Assumptions:

##   1. Execute 'download.R' which fetches and unzips dataset for assignment.
##   2. Current working directory is set to the same directory where dataset
##      was uncompressed.  e.g. Subdirectory exists called "UCI HAR Dataset"

##########################################################################
##
##  This section load data in preparation for analysis
##
##########################################################################

## Load metadata UCI datasets into R
## 4. Appropriately labels the data set with descriptive variable names.

library(dplyr)  ## load packages supporting needed analytical operations

features <- read.table("UCI HAR Dataset\\features.txt",
                       col.names=c("featureid", "feature"))
activities <- read.table("UCI HAR Dataset\\activity_labels.txt",
                         col.names=c("activityid", "activity"))

## Clean metadata to remove special characters and improve readability

features <- mutate(features, feature=gsub("\\(\\)","", feature))  ## remove ()
features <- mutate(features, feature=gsub("tBody","timebody", feature))
features <- mutate(features, feature=gsub("tGravity","timegravity", feature))
features <- mutate(features, feature=gsub("fBodyBody","fBody", feature))
features <- mutate(features, feature=gsub("fBody","fftbody", feature))
features <- mutate(features, feature=gsub("Acc","acceleration", feature))
features <- mutate(features, feature=gsub("Gyro","gyroscope", feature))
features <- mutate(features, feature=gsub("Mag","magnitude", feature))
features <- mutate(features, feature=gsub("Mean","mean", feature))
features <- mutate(features, feature=gsub("Freq","frequency", feature))
features <- mutate(features, feature=gsub("Energy","energy", feature))
features <- mutate(features, feature=gsub("Jerk","jerk", feature))
## resolve raw formatting error specific to featureid 556
features <- mutate(features, feature=gsub("),",",", feature))
## remove ( and ) and , from all 'angle' features
features <- mutate(features, feature=gsub("\\(","of-", feature))
features <- mutate(features, feature=gsub("\\)","", feature))
features <- mutate(features, feature=gsub(",","-and-", feature))

## load train and test datasets with column names from 'features' temp dataset

train <- read.table("UCI HAR Dataset\\train\\X_train.txt",
                    col.names=features[,2])

test <- read.table("UCI HAR Dataset\\test\\X_test.txt",
                   col.names=features[,2])

train_activities <- read.table("UCI HAR Dataset\\train\\y_train.txt",
                               col.names=c("activityid"))

test_activities <- read.table("UCI HAR Dataset\\test\\y_test.txt",
                              col.names=c("activityid"))

train_subjects <- read.table("UCI HAR Dataset\\train\\subject_train.txt",
                             col.names=c("subjectid"))
test_subjects <- read.table("UCI HAR Dataset\\test\\subject_test.txt",
                            col.names=c("subjectid"))

##########################################################################
##
##  All nesseary data has been loaded into R
##  This section cleans and processes the data per assignment requirements
##
##########################################################################

## Integrate activities and subject data into train and test datasets
## 3. Uses descriptive activity names to name the activities in the data set

train <- bind_cols(train, train_subjects, train_activities)
test <- bind_cols(test, test_subjects, test_activities)

train <- merge(train, activities)
test <- merge(test, activities)
train$activityid <- NULL
test$activityid <- NULL

## Discard temporary metadata dataframes which have been integrated with
##   the primary data tables.

rm(test_activities, train_activities, activities)
rm(test_subjects, train_subjects)
rm(features)

## Merge sets and retain original category 'type' either("Train" or "Test")
## 1. Merge the training and test data sets to create one data set.  

train <- mutate(train, type="Train")
test <- mutate(test, type="Test")

combined_raw <- bind_rows(test, train)

rm(train, test)  ## remove disaggregated temporary raw datasets

## 2. Extract only the measurements on the mean and standard deviation
##    for each measurement

human_activity <- select(combined_raw, type, activity, subjectid,
                 grep("mean|std", names(combined_raw), ignore.case=TRUE))

## 'humanactivity' dataset fulfils assignment requirements 1-4
##    This tidy dataset only includes mean and standard deviation features

## 5. Create a second, indepdendent tidy data set with the average
##    of each variable for each activity and each subject.

grouped <- mutate(human_activity, subjectid=factor(subjectid),
                  activity=factor(activity))
grouped$type <- NULL
grouped <- group_by(grouped, subjectid, activity)
summary <- summarize_each(grouped, funs(mean))

## 'summary' dataset fulfils assignment requiement #5
##    this summarizes each variable from human_activity by
##    subject and activity

rm(grouped)  ## remove temporary dataset
