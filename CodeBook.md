Cleaning the Human Activity Recognition Using Smartphones Dataset (Version 1.0)
===================
The dataset was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on the 23rd October 2014.

# Merging the dataset / descriptive activity names
1. All six data tables (main dataset, seperate subject and activity datasets, both from the train and test sections) where loaded into seperate files using read.table
2. The names of the features where obtained from the features.txt file, and applied to the two main data tables
3. The activity codes where manually encoded (since they where just six)
4. The subject and activity tables where added (column-wise) to the respective main tables
5. The activity codes where replaced by the mapping in step 3
6. Lastly the two (train and test) datasets where merged using rbind

# Extracting measurements on the mean and standard deviation for each measurement.
1. Was done using grep: only the colums where selected that contained mean() or std(). This is justified by the feature description in the dataset (feature_info.txt, line 33,34). This resulted in 66 variables for our new dataset.

# Labels the data set with descriptive variable names. 
According to tidy data principles, 
1. variables where made lowercase
2. variables where stripped of dashes and other irregular characters
3. abbreviations like acc, f, t and gyro where written out

# Average of each variable for each activity and each subject
1. In order to generate the average for each variable by activity and subject, I first used melt(), and then aggregate.
2. The resulting data.frame was validated by a simple calculation: given 66 relevant variables, 6 types of activities and 30 unique subjects, we get 30x66x6 = 11880 averages. This correspondet to the number of rows in the result data frame.