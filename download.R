## 8-Sep-2016
## Paul Kavitz
## Programming Assignment for Course 3, "Getting and Cleaning Data"
## Purpose of this script is to fetch, unzip, and load the data
##   in preparation for analysis.

## Doanload and unzip the file into the current working directory.
download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    "dataset.zip")
unzip("dataset.zip")

