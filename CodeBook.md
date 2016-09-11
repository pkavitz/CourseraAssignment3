---
title: "CodeBook"
author: "Paul Kavitz"
date: "September 10, 2016"
output: html_document
---

## Getting and Cleaning Data Course Project

This code book describes the transformations applied by the **"run_analysis.R"** script to prepare and clean the sample dataset to meet the review criteria specified in the course assignment.

### Assumptions:
1. You have executed **"download.R"** and retrieved the raw dataset onto your local file system.
2. You are using the latest version of R Studio and have **set the working directory** to the same directory into which the raw dataset was decompressed.

### Transformations performed by 'run_analysis.R':
1. **Load raw data into R**
    + Raw data sets (X_train.txt and X_test.txt)
    + Associated acivity data (y_train.txt and y_test.txt)
    + Associated subject data (subject_train.txt and subject_test.txt)
    + and metadata (features.txt and activity_labels.txt)
2. **Scrub features variable/attribute dataset to improve readability**
    + *Note: Fulfils requirement #4 - appropriately label the data set with descriptive variable names.*
    + Remove ()s from all features
    + expand abbreviations into readable lowercase words:
        + t -> time
        + BodyBody and body -> body
        + Gravity -> gravity
        + f -> fft
        + Acc -> acceleration
        + Gyro -> gyroscope
        + Mag -> magnitude
        + Mean -> mean
        + Freq -> frequency
        + Energy -> energy
    + specific formating changes to *angle* variables:
        + remove additional ) error in featureid 556
        + leading ( changed to of-
        + removed trailing )
        + changed intermediate , to -and-
3. **Combine subjects and activities with test and train raw data**
    + *Note: Fulfils requirement #3 - Uses descriptive activity names to name the activities in the data set.*
    + Train dataset combined with train subjects and train activities
    + Test dataset combined with test subjects and test activities
    + Activity names merged with activity IDs into combined datasets and activityID variable discarded.
4. **Combine the test and train datasets into a single dataframe.**
    + Note: Fulfils requirement #1 - Merge the training and test data sets to create one data set.*
    + Added 'type' variable to retain designation of observations into "Train" and "Test" categories
    + **combined_raw** dataset contains the result of the previous transformations.
5. **Extract measurements on mean and standard deviation for each measurement.**
    + *Note: fulfils requirement #2*
    + **human_activity** dataset contains the subset of mean and standard deviation measurements from the original observations
    + ```grep("mean|std")``` used to subset variables.
6. **Summarize the dataset**
    + *Note: fulfils requirement #5 - create a 2nd independent tidy data set with the average of each variable for each activity and each subject.*
    + *subjectid* and *actviity* turned into factor variables
    + combined dataset grouped by *subjectid* and *activity* factor variables.
    + **summary** dataframe contains mean of each measurement from **human_activity** summarized by *subjectid* and *activity*.
    
## Output datasets
1. **combined_raw** dataset aggregates the *train* and *test* datasets for **all** measurements, along with associated activity and subjectid.
    + Variable names for all 561 original measurements are tidy and human readable, for example:
        + ```timebodyaccelerationjerkmagnitude.min```
        + ```angleof.timebodygyroscopemean.and.gravitymean```
        + ```timebodygyroscopejerk.std.X```
    + Variable *type* contains one of two values ("Train", "Test") indicating the appropriate category of observation from the raw data.
    + Variable *activity* contains one of the six activity names for the observation.
    + Variable *subjectid* contains the subject number for the observation.
2. **human_activity** dataset is a subset of **combined raw** containing only those observations with the expression *"mean"* or *"std"*
    + Variable *type* contains one of two values ("Train", "Test") indicating the appropriate category of observation from the raw data.
    + Variable *activity* contains one of the six activity names for the observation.
    + Variable *subjectid* contains the subject number for the observation.
    + Remaining 86 meausrement variables from the combined_raw dataset
3. **summary** dataset summarizes the mean of all measurements from **human_activity** grouped by activity and subjectid factors.