---
title: "Code Book"
author: "Celso Castro"
date: "Wednesday, July 22, 2015"
output: html_document
---

#Code Book

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#DATA AND VARIABLE DESCRIPTION

The data is recolected from the experiments where a group of 30 volunteers (age range of 19-48 years) performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone) on the waist.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data (7352 observations) and 30% the test data (2947 observations). 

To capture the 3-axial linear acceleration (tAcc-XYZ) and 3-axial angular velocity(tGyro-XYZ) for each indivudual they used an accelerometer a and gyroscope, at a constant rate of 50Hz (where the prefix t means time).  

The sensor signals (accelerometer (tBodyAcc-XYZ)  and gyroscope tGravityAcc-XYZ ) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 

The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration (tBodyAcc-XYZ) and gravity (tGravityAcc-XYZ). 

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). The magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Abbreviation | Explanation
-------------|--------------
prefix t     | time
prefix f     | frequency  
Body| Body movement 
Acc| Acceleration
Gravity | Gravity acceleration
Jerk |Rate of change of acceleration
Gyro | Measure from the gyroscop
Mag | Magnitude
Mean() | Mean Value
StdDev | Standard Deviation

##CLEANING DATA AND WORKING WITH DATA
I created a R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

        + First call the libraries that are going to be used
        + Extract and read the necesary files (both train and test):
                + Feature data (column names)
                + Subject (id)
                + Activity number (Y)
                + Data recolected (X)
                + Activity names (Activity_labels)
        + Merge the train and test set
        
2. Extracts only the measurements on the mean and standard deviation for each measurement. 

        + Creates a table named dataset.
        
3. Uses descriptive activity names to name the activities in the data set.

        + Uses the names from the file Activity_labels

4. Appropriately labels the data set with descriptive variable names.

        + Sets the variable names as characters.
        + Rename the variables
        
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

        + The file produced is finaltidyset.txt
