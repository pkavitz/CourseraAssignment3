---
title: "README.md"
author: "Paul Kavitz"
date: "September 10, 2016"
output: html_document
---

## Getting and Cleaning Data Course Project

Two scripts are required to execute all steps necessary to prepare and clean the sample dataset to meet the review criteria specified in the course assignment.

### Assumptions:
1. Internet connection and the latest version of RStudio is installed.
2. Working directory is set to the location you want to store the raw dataset.

### Scripts
- **"download.R"** - retrieves raw data set from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and uncompresses into the local file system.
- **"run_analysis.R"** imports raw data set into R dataframes and performs a sequence of steps to transform the raw data into tidy data according to the specifications identified in the course assignment.
    + **Refer to "CodeBook.md"" for a review of tranformations performed by this script.**

Have a fantastic day!