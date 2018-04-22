cleanDataHAR <- function() {

## load libraries
library (dplyr)
library (reshape2)

## STEP1 :  Merges the training and the test sets to create one data set.

## read the activity label and feature list
activity_label <- read.table ("activity_labels.txt", header=FALSE, col.names=c("actnum","actdescr"))
features <- read.table ("features.txt", header=FALSE, col.names=c("featnum","featdescr"))

## read the train dataset and set names for the columns using reference tables listed above
subject_train <- read.table("train/subject_train.txt",header=FALSE, col.names="subject")
x_train <- read.table("train/x_train.txt",sep="", header=FALSE, col.names=features$featdescr)
y_train <- read.table("train/y_train.txt",sep="", header=FALSE, col.names="actnum")

## read the test dataset and set names for the columns using reference tables listed above
subject_test <- read.table("test/subject_test.txt",header=FALSE, col.names="subject")
x_test <- read.table("test/x_test.txt",sep="", header=FALSE, col.names=features$featdescr)
y_test <- read.table("test/y_test.txt",sep="", header=FALSE, col.names="actnum")

## build a data frame with all variables 
subject_all <- rbind (subject_train, subject_test)
x_all <- rbind (x_train, x_test)
y_all <- rbind (y_train, y_test)

## build a complete data frame
dt_all <- cbind (subject_all, x_all, y_all)

## clean the environment removing unnecessary objects from memory
rm (subject_train, subject_test, x_train, x_test, y_train, y_test)
rm (subject_all, x_all, y_all)

## STEP2 :  Extracts only the measurements on the mean and standard deviation for each measurement.
##          As per documentation in page 440 of the ref document, meanFreq should not be considered as a mean variable
dt_mean_std <- select (dt_all,subject, actnum, contains("mean"), contains ("std"),-contains("meanFreq"))

## STEP3 :  Uses descriptive activity names to name the activities in the data set
##          adds the activity description - actdescr column to dt_mean_std DF 
dt_mean_std <- merge (dt_mean_std, activity_label, by="actnum")

## STEP4 :  Appropriately labels the data set with descriptive variable names.

dt_melt <- melt (dt_mean_std, id=c("actnum","subject","actdescr"))
dt_melt <- rename (dt_melt, features=variable, measurement=value)
dt_melt <- arrange (dt_melt, subject, actnum)

## STEP5 :  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Summarize 
dt_melt_sum <- dt_melt %>% group_by(subject, actdescr, features) %>% summarize (mean_val=mean(measurement)) %>% ungroup () %>% ungroup () %>% arrange (subject, actdescr, features)

## write DataSet to files

write.table (dt_melt,file="tidy_melt_dataset.txt", quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)
write.table (dt_melt_sum,file="summary_melt_datset.txt", quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)

}
