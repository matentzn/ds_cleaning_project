library(reshape2)
# Merges the training and the test sets to create one data set.

train_raw <- read.table("UCI HAR Dataset/train/X_train.txt")
test_raw <- read.table("UCI HAR Dataset/test/X_test.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity.code <- c(WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, SITTING=4,  STANDING=5,LAYING=6)

names(test_raw) <- features$V2
names(train_raw) <- features$V2
test_raw$activity <- test_activity$V1
train_raw$activity <- train_activity$V1
test_raw$subject <- test_subject$V1
train_raw$subject <- train_subject$V1
data <- rbind(train_raw,test_raw)
# Uses descriptive activity names to name the activities in the data set
data$activity <- names(activity.code)[match(data$activity, activity.code)]
# Extracts only the measurements on the mean and standard deviation for each measurement.
only_std_and_mean <- data[,grep("mean[(][)]|std[(][)]|^activity$|^subject$", names(data), value=TRUE)]
# Appropriately labels the data set with descriptive variable names. 
names(only_std_and_mean) <- tolower(names(only_std_and_mean))
names(only_std_and_mean) <- gsub("[-]"," ",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("[()]","",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("bodyacc","body acceleration",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("bodygyro","body gyroscope",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("fbody","frequency body",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("tbody","time body",names(only_std_and_mean))
names(only_std_and_mean) <- gsub("tgravity","time gravity",names(only_std_and_mean))
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
m <- melt(only_std_and_mean, id.vars = c("subject", "activity"))
#m <- m[!is.na(m$start_pc), ]
summary_by_subject_activity <- aggregate( value~subject+activity+variable, m, mean)
write.table(summary_by_subject_activity,file="summary_by_subject_activity.txt",row.name=FALSE)
