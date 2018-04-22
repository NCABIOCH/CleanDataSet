# CleanDataSet
Project submission for Getting and Cleaning Data Course Project

This repository contains my submission for the final project of the "Getting and Cleaning Data" Course in the Data Scientist cursus from John Hopkins University.

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Source DataSet 
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## This repo contains one R script called run_analysis.R that does the following.

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Additional material submitted in the repo
1) a tidy data called tidy_melt_dataset.txt, providing tidy data after the application of the r script (here provided as a rar compressed file due to size of the file)
2) a summary data set called summary_melt_datset.txt providing mean calculation for each group of activity and variable for each subject
3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md. 
It also include this README.md in the repo with your scripts. 

