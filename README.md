#Read Me
#Getting and Cleaning Data Course Project

##Purpose
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

##Explanation of the code

First i call the librarys that will be used


```r
library(dplyr)
library(data.table)
```

Extract the data from the zip file


```r
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
```

Set the directory where the files were extracted


```r
dir<-"C:/Users/Celso/Documents/UCI HAR Dataset"
```

Read first the test data then the train data


```r
testdata  <- tbl_df(read.table(file.path(dir, "test" ,       "X_test.txt" )))
testsub   <- tbl_df(read.table(file.path(dir, "test" , "subject_test.txt" )))
testact   <- tbl_df(read.table(file.path(dir, "test" ,       "Y_test.txt" )))

traindata <- tbl_df(read.table(file.path(dir, "train",       "X_train.txt")))
trainsub  <- tbl_df(read.table(file.path(dir, "train", "subject_train.txt")))
trainact  <- tbl_df(read.table(file.path(dir, "train",       "Y_train.txt")))
```

##1. Merge the training and the test sets to create one data set.

To merge the train and test data sets the command rbind was used,


```r
datasub<-rbind(testsub,trainsub)
dataact<-rbind(testact,trainact)
datatot<-rbind(testdata,traindata)
```

I renamed the name columns from the merged data


```r
setnames(datasub, "V1", "sujeto")
setnames(dataact, "V1", "numactividad")
```

To rename the the third data set i extracted the names from the features file


```r
caracteristica<-tbl_df(read.table(file.path(dir, "features.txt")))
setnames(caracteristica,names(caracteristica),c("numactividad","nombre"))
colnames(datatot)<-caracteristica$nombre
```

Then to get the activity number and name i create a table from the activity labels file


```r
actividad<- tbl_df(read.table(file.path(dir, "activity_labels.txt")))
setnames(actividad, names(actividad), c("numactividad","nombre"))
```

Once i have all the info i create a unique table that shows the subject, number and names of activities.


```r
datatot<-cbind(datasub,dataact,datatot)
```

##2.Extracts only the measurements on the mean and standard deviation for each measurement. 

First we extract the column names and attach the subject and activity number.


```r
tablamediadesv <- grep("mean\\(\\)|std\\(\\)",caracteristica$nombre,value=TRUE) 
tablamediadesv<- union(c("sujeto","numactividad"), tablamediadesv)
```

Then the data table with the required information will be a subset with the previous specifications.


```r
dataset<-subset(datatot,select=tablamediadesv) 
```

##3.Use descriptive activity names to name the activities in the data set
I incorporate the names of the activities.

```r
dataset <- merge(actividad, dataset , by="numactividad", all.x=TRUE)
```

##4. Appropriately labels the data set with descriptive variable names. 
First i set the names as character so i can rename them.


```r
dataset$nombre <- as.character(dataset$nombre)
```

Then i give a more descriptive name to the variables. (Only renaming the ones i used)


```r
names(dataset)<-gsub("^t", "Time", names(dataset))
names(dataset)<-gsub("^f", "Frequency", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("Acc", "Accelerometer", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))
names(dataset)<-gsub("mean()", "Mean", names(dataset))
names(dataset)<-gsub("std()", "StdDev", names(dataset))
```
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


```r
datagregada<- aggregate(. ~ sujeto - nombre , data = dataset, mean) 
datafin<- tbl_df(arrange(datagregada,sujeto,nombre))
```

Finally i create i file with the requirements

```r
write.table(dataset, "tidydataset.txt", row.name=FALSE)
```




