## Peer Assessment for Getting and Cleaning Data

This code was written for a [peer assessment assignment] [pa_src] for   
Coursera's Getting and Cleaning Data course.  An explanation of the dataset  
can be found [here] [ml_src].  The data for this source was downloaded from  
[here] [d_src].

  [pa_src]: https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions
  [ml_src]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  [d_src]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###  The Initial Data

The data is comprised of a set of measurements derived from the accelerometer  
and gyroscope of a Samsung Galaxy S II.  Each observation is a vector of 561  
variables.  All these observations are split into a training set and test set.  
The activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,  
LAYING) and subject ID number corresponding to each observation are stored in  
separate files.  There are two files with label data that I also used.

The files used are:
* train/X_train.txt - measurement data in the training set
* train/Y_train.txt - activity identifiers for the observations in X_train.txt
* train/subject_train.txt - subject identifiers for X_train.txt
* test/X_test.txt - measurement data in the test set
* test/Y_test.txt - activity identifiers for the observations in X_test.txt
* test/subject_test.txt - subject identifiers for X_test.txt
* features.txt - set of identifiers for the measurements in X_*.txt
* activity_labels.txt - set of labels for the six activities

All files are assumed to be within the 'UCI HAR Dataset' directory within the  
working directory.

###  Cleaning Process

The run_analysis.R script is fairly straight forward with no processing done  
on the measurements themselves.

1.  Load all eight files into dataframes.
2.  Row bind the training and test dataframes together, resulting in  
	three dataframes - subjects, activities, and measurements.
3.  Change the column names of each dataframe to something more descriptive.  
	For the measurement data I used the labels found in features.txt.
4.  Change the activity int codes into factor labels using activity_labels.txt.
5.  Select a subset of the measurement data by grepping on 'mean()' and 'std()'
6.  Clean up the column names of resulting subset by removing '()' and changing  
	all '-'s to '.'s.
7.  Column bind the subjects, activities, and subsetted measurements dataframes  
	into a single dataframe.
8.  Create a new dataframe containing the mean of each measurement over all  
	activities and subjects using aggregate.
9.  Write the new tidy dataframe to a file 'gcdata_peer.txt'

### Variables

There are 68 variables - activity, subject.id, and 66 measurement variables.  
The measurement variables are named according to the following format:  

1.  Begins with f or t depending on whether they were taken in the frequency  
	or time domains.  
2.  'Body' or 'Gravity' depending on whether the measurement is due to  
	gravitational acceleration or bodily motion.  
3.  An abbreviation of the type of measurement.  
4.  'mean' or 'std'  
5.	The axis of measurement, if applicable.  

activity - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,  
or LAYING  
subject.id - integer code to differentiate subjects, 1-30  
tBodyAcc.mean.X  
tBodyAcc.mean.Y  
tBodyAcc.mean.Z  
tBodyAcc.std.X  
tBodyAcc.std.Y  
tBodyAcc.std.Z  
tGravityAcc.mean.X  
tGravityAcc.mean.Y  
tGravityAcc.mean.Z  
tGravityAcc.std.X  
tGravityAcc.std.Y  
tGravityAcc.std.Z  
tBodyAccJerk.mean.X  
tBodyAccJerk.mean.Y  
tBodyAccJerk.mean.Z  
tBodyAccJerk.std.X  
tBodyAccJerk.std.Y  
tBodyAccJerk.std.Z  
tBodyGyro.mean.X  
tBodyGyro.mean.Y  
tBodyGyro.mean.Z  
tBodyGyro.std.X  
tBodyGyro.std.Y  
tBodyGyro.std.Z  
tBodyGyroJerk.mean.X  
tBodyGyroJerk.mean.Y  
tBodyGyroJerk.mean.Z  
tBodyGyroJerk.std.X  
tBodyGyroJerk.std.Y  
tBodyGyroJerk.std.Z  
tBodyAccMag.mean  
tBodyAccMag.std  
tGravityAccMag.mean  
tGravityAccMag.std  
tBodyAccJerkMag.mean  
tBodyAccJerkMag.std  
tBodyGyroMag.mean  
tBodyGyroMag.std  
tBodyGyroJerkMag.mean  
tBodyGyroJerkMag.std  
fBodyAcc.mean.X  
fBodyAcc.mean.Y  
fBodyAcc.mean.Z  
fBodyAcc.std.X  
fBodyAcc.std.Y  
fBodyAcc.std.Z  
fBodyAccJerk.mean.X  
fBodyAccJerk.mean.Y  
fBodyAccJerk.mean.Z  
fBodyAccJerk.std.X  
fBodyAccJerk.std.Y  
fBodyAccJerk.std.Z  
fBodyGyro.mean.X  
fBodyGyro.mean.Y  
fBodyGyro.mean.Z  
fBodyGyro.std.X  
fBodyGyro.std.Y  
fBodyGyro.std.Z  
fBodyAccMag.mean  
fBodyAccMag.std  
fBodyBodyAccJerkMag.mean  
fBodyBodyAccJerkMag.std  
fBodyBodyGyroMag.mean  
fBodyBodyGyroMag.std  
fBodyBodyGyroJerkMag.mean  
fBodyBodyGyroJerkMag.std  
