##  This file loads and cleans activity measurement data and provides a tidy
##  data set as a result.


##  Load all the data files
##  Data was downloaded from 'https://d396qusza40orc.cloudfront.net/
##  getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
##  Data is assumed unzipped into the 'UCI HAR Dataset' folder.
##  There are two subdirectories, \train and \test, each containing 3 files with
##  the subject codes, activity codes, and measurment data for each record.
##  There are two other files loaded, features.txt and activity_labels.txt,
##  which contain label information

train_dir <- 'UCI HAR Dataset/train'
sub_tr_url <- paste(train_dir, 'subject_train.txt', sep = '/')
x_tr_url <- paste(train_dir, 'X_train.txt', sep = '/')
y_tr_url <- paste(train_dir, 'Y_train.txt', sep = '/')

sub_train <- read.table(sub_tr_url)
x_train <- read.table(x_tr_url)
y_train <- read.table(y_tr_url)


test_dir <- 'UCI HAR Dataset/test'
sub_test_url <- paste(test_dir, 'subject_test.txt', sep = '/')
x_test_url <- paste(test_dir, 'X_test.txt', sep = '/')
y_test_url <- paste(test_dir, 'Y_test.txt', sep = '/')

sub_test <- read.table(sub_test_url)
x_test <- read.table(x_test_url)
y_test <- read.table(y_test_url)


# The features.txt file contains descriptive names for each column, which I'll
# use to name and identify mean and std measurements
top_dir <- 'UCI HAR Dataset'
feat_url <- paste(top_dir, 'features.txt', sep = '/')
feat_lab <- read.table(feat_url, stringsAsFactors=FALSE)

# The activity_labels.txt file contains descriptive names for each activity, 
# which I'll use to label the activity codes
act_url <- paste(top_dir, 'activity_labels.txt', sep = '/')
act_lab <- read.table(act_url, stringsAsFactors=FALSE)


##  Merge them all

subjects <- rbind(sub_train, sub_test)
activities <- rbind(y_train, y_test)
measurements <- rbind(x_train, x_test)

# Give descriptive column names
colnames(subjects) <- 'subject.id'
colnames(activities) <- 'activity'
colnames(measurements) <- feat_lab$V2

# Give descriptive activity labels
activities$activity <- factor(activities$activity, labels=act_lab$V2)

# Take just mean and std measurements.  I assume that each has either 'mean()'
# or 'std()' in its name.
meas_sub <- measurements[, grepl('mean()', colnames(measurements), fixed=TRUE) | 
                        grepl('std()', colnames(measurements), fixed=TRUE)]

# Clean up the remaining column names, removing () and changing '-' to '.'
colnames(meas_sub) <- gsub('()', '', colnames(meas_sub), fixed=TRUE)
colnames(meas_sub) <- gsub('-', '.', colnames(meas_sub), fixed=TRUE)

final <- cbind(subjects, activities, meas_sub)


## Create second, independent tidy data set with the average of each variable
## for each activity and each subject

final2 <- aggregate(. ~ activity + subject.id, data = final, mean)


## Write final2 to a .txt file for uploading

write.table(final2, 'gcdata_peer.txt', row.names=FALSE, sep='\t', quote=FALSE)
