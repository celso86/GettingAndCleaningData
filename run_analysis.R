#Extract the data from the zip file
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

#Set the directorye where the files were extracted
dir<-"C:/Users/Celso/Documents/UCI HAR Dataset"

#Read first the test data then the train data
testdata  <- tbl_df(read.table(file.path(dir, "test" ,       "X_test.txt" )))
testsub   <- tbl_df(read.table(file.path(dir, "test" , "subject_test.txt" )))
testact   <- tbl_df(read.table(file.path(dir, "test" ,       "Y_test.txt" )))

traindata <- tbl_df(read.table(file.path(dir, "train",       "X_train.txt")))
trainsub  <- tbl_df(read.table(file.path(dir, "train", "subject_train.txt")))
trainact  <- tbl_df(read.table(file.path(dir, "train",       "Y_train.txt")))

#MERGING THE TEST AND TRAIN DATASETS
datasub<-rbind(testsub,trainsub)
dataact<-rbind(testact,trainact)
datatot<-rbind(testdata,traindata)
setnames(datasub, "V1", "sujeto")
setnames(dataact, "V1", "numactividad")

##USING THE ACTIVITY_LABELS TEXT THE NAMES OF THE ACTIVITY WILL BE SET
actividad<- tbl_df(read.table(file.path(dir, "activity_labels.txt")))
setnames(actividad, names(actividad), c("numactividad","nombre"))

#USING THE NAMES IN THE FEATURE TEXT FILE THE NAMES OF THE COLUMN IN THE 
#MERGED TOTAL DATA SET WILL BE RENAMED
caracteristica<-tbl_df(read.table(file.path(dir, "features.txt")))
setnames(caracteristica,names(caracteristica),c("numactividad","nombre"))
colnames(datatot)<-caracteristica$nombre
#NEXT STEP IS TO CREATE A SINGLE TABLE
datatot<-cbind(datasub,dataact,datatot)

#A NEW DATASET WITH ONLY THE MEANS AND SD FROM THE FEATURES WILL BE CREATED.
#I FIRST EXTRACT THE COLUMN NAMES THEN ATTACH THE SUBJECT AND ACTIVITY NUMBER
tablamediadesv <- grep("mean\\(\\)|std\\(\\)",caracteristica$nombre,value=TRUE) 
tablamediadesv<- union(c("sujeto","numactividad"), tablamediadesv)
#FINALLY FROM THE TOTAL SET I CREATE THE SUBSET WITH THE REQUIRED VARIABLES
dataset<-subset(datatot,select=tablamediadesv) 

#USING MERGE I INCORPORATE THE NAMES OF THE ACTIVITIES AND SET THEM AS CHARACTERS
dataset <- merge(actividad, dataset , by="numactividad", all.x=TRUE)
dataset$nombre <- as.character(dataset$nombre)


#Now it is possible to rename the variables to give a more descriptive name.
#IM ONLY RENAMING THE USED VARIABLES
names(dataset)<-gsub("^t", "Time", names(dataset))
names(dataset)<-gsub("^f", "Frequency", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("Acc", "Accelerometer", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))
names(dataset)<-gsub("mean()", "Mean", names(dataset))
names(dataset)<-gsub("std()", "StdDev", names(dataset))

write.table(dataset, "tidydataset.txt", row.name=FALSE)


## create dataTable with variable means sorted by subject and Activity

datagregada<- aggregate(. ~ sujeto - nombre , data = dataset, mean) 
datafin<- tbl_df(arrange(datagregada,sujeto,nombre))

