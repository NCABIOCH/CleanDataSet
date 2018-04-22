This file contains a description of the manipulated (Original) and generated datasets (Solutions) as well as the actions performed 
(transformations) to get the generated DataSet data from the original DataSet. 
## Original DataSet
From the global zip collected in the url, we use the following files as Original DataSets
1 - activity_labels.txt links an actnum integer with a label describing the activity (further referred as actdescr)
2 - features.txt links an featnum integer with a label describing the feature (further referred as featdescr)
both will be used as reference table to map id of activity and of features to label describing the corresponding activities and features 
in the tidy dataset
files from the "train" phase DataSet are located in the /train folder - they représent 70% (7352 obs) of the collected information
3 - subject_train.txt contains a single column with a identifier code for the user (subject) being observed in the train phase
4 - x_train.txt contains 561 columns (representing different variables) collected in the train phase (raw and summarized data)
5 - y_train.txt contains a single column with the activity code (actnum) valued between 1 and 6 representing the activity being recored 
Each row in each file is corresponding to the same observation (user, variable, activity)
files from the "test" phase DataSet are located in the /test folder - they représent 30% (2947 obs) of the collected information
3 - subject_test.txt contains a single column with a identifier code for the user (subject) being observed in the train phase
4 - x_test.txt contains 561 columns (representing different variables) collected in the train phase (raw and summarized data)
5 - y_test.txt contains a single column with the activity code (actnum) valued between 1 and 6 representing the activity being recored 
Each row in each file is corresponding to the same observation (user, variable, activity)
features describtion (featdescr) can be used to map the variable in the x_ files (where the corresponding column number should be 
matched with featnum to create the link

## Resulting DataSet
The first resulting DataSet is the tidy_melt_dataset.txt. It contains the consolidated and cleaned set of observations 
(751827 observations + 1 header raw). It contains for each observation a raw with the following variables
1 - Actnum : is an integer corresponding to the activity code - possible values are between 1 and 6 and correspond to (1=WALKING, 2=WALKING UPSTAIRS,
3=WALKING DOWNSTAIRS, 4=SITTING, 5=STANDING, 6=LAYING)
2 - subject : an integer value corresponding to the subject (user) being observed
3 - actdescr : a string that contains the description of the activity corresponding to actnum
4 - features - the set of variable names that are observed in each row - they are a subset of the oringinal variable limited to means and
standard deviation values
5 - measurement : the measurement observed for the (subject, activity, variable) raw observation

## Data Transformation
1 - the activity_labels.txt and features.txt files are read and loaded in Data Frames in R
2a - subject_train.txt is read and loaded in a DataFrame called subject_train with as "subject" as the column name for its single column
2b - x_train.txt is read and loaded in a DataFrame called x_train with features list collected in step 1 as the column names 
for its columns
2c - y_train.txt is read and loaded in a DataFrame called y_train with actnum list collected in step 1 as the column names 
for its single column
3 - same operation as in 2 is performed for test files (subject, x and y) and load DataFrame subject_test, x_test and y_test
4a -using an rbind operation subject_train and subject_test are binded to create a subject_all DataFrame with all obeservations
4b -using an rbind operation x_train and x_test are binded to create a x_all DataFrame with all obeservations
4c -using an rbind operation y_train and y_test are binded to create a y_all DataFrame with all obeservations
5 - using a cbind command, a dt_all DataFrame is created to bind for each obs raw the column value in subject, x and y DF 
6 - cleaning the environment to free memory is done through rm on no more needed dataframes, and 
this concludes the STEP 1
7 - using the select command on dt_all DataFrame, a new DataFrame called dt_mean_std subset the dt_all DataFrame and keeps only subject, 
actnum and all variables corresponding to means or std (except the ones have meanFreq in their description, as they are not considered
in the mean group according to documentation p 440)
STEP 2 is complete
8 - By using the merge command on dt_mean_std and activity_label DataFrames on actnum variable, a description of the activity is added 
to dt_mean_std
STEP 3 is complete
9 - melt command on dt_mean_std DataFrame enables to flatten the DataFrame having a raw for each (subject, actdescr, variable)
10 - rename commande enables to modify the column name for the DataSet making them a bit more understandable (feature instead of variable 
and measurement instead of value)
11 - the arrange command orders the dataframe raw for a better readability of the raw file
STEP 4 is complete
12 - a new DataFrame dt_melt_sum is created using the chaining (%>%) function, by first applying groups (subject, actdescr, features) on dt_melt
then summarize feature immplementing a mean calculation for the values in each category of the group and then ungrouping the two levels 
of groups used to finally arrange the DF according to (subject, actdescr, features) order
13-a first file called tidy_melt_dataset.txt is created on working directory with dt_melt tidy data (separator is " ")
14-a second file called summary_melt_datset.txt.txt is created on working directory with dt_melt_sum grouped mean data (separator is " ")
FINAL STEP is complete
