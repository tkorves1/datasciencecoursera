#This script creates some summary data from the dataset called "Human Activity Recognition Using Smartphones Dataset".  It selects the mean and standard deviation measurements for each of the features measured in the dataset and calculates means for each of these for each activity-human subject pair.


# The website for this dataset is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Download the data into dfs

#setwd to your working directory

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(! file.exists("Cdata")){dir.create("Cdata")
}
temp<-tempfile()
download.file(fileUrl,temp)
for (i in temp){
  unzip(i,exdir="./Cdata")
}
#list.files("./Cdata")

#Read in data

testData<-read.table("./Cdata/UCI HAR Dataset/test/X_test.txt",header=FALSE)
trainingData<-read.table("./Cdata/UCI HAR Dataset/train/X_train.txt",header=FALSE)

features<-read.table("./Cdata/UCI HAR Dataset/features.txt")
featureNames<-as.character(features$V2)

colnames(testData)<-c(featureNames)
colnames(trainingData)<-c(featureNames)

#Reduce Data sets to mean and std of features only

features1<-data.frame(featureNames,stringsAsFactors=FALSE)

#Get true/false on whether contain mean, std
#"mean ()" is used so that variable names with meanFreq, which I don't think should be considered, are not included

features1$mean<-grepl(("mean()"),features1$featureNames)
features1$meanFreq<-grepl(("meanFreq()"),features1$featureNames)
features1$std<-grepl(("std"),features1$featureNames)

#include those where either true

featuresToInclude<-features1$featureNames[(features1$mean==TRUE|features1$std==TRUE)& features1$meanFreq==FALSE]

#Reduce data set to colms in this set where contain mean and std

testData2<-testData[,colnames(testData) %in% featuresToInclude]
trainingData2<-trainingData[,colnames(trainingData) %in% featuresToInclude]


#read in activity data labels

trainingActLabels<-read.table("./Cdata/UCI HAR Dataset/train/y_train.txt",header=FALSE)
testActLabels<-read.table("./Cdata/UCI HAR Dataset/test/y_test.txt",header=FALSE)

#Add order to these so that can reorder correctly after merge to line up with measurement data
trainingActLabels$order<-1:nrow(trainingActLabels)
testActLabels$order<-1:nrow(testActLabels)


#Read in file that has the descriptive names corresponding to the activity numbers

ActivityLabels<-read.table("./Cdata/UCI HAR Dataset/activity_labels.txt",header=FALSE)
colnames(ActivityLabels)[2]<-"Activity"



#Merge activity names with activity label numbers
trainingActLabelNames<-merge(trainingActLabels,ActivityLabels,by="V1")
testActLabelNames<-merge(testActLabels,ActivityLabels,by="V1")

#Reorder the Activity number according to the original order

trainingActLabelNames<-trainingActLabelNames[order(trainingActLabelNames$order),]
testActLabelNames<-testActLabelNames[order(testActLabelNames$order),]


#Remove the order variable
trainingActLabelNames<-trainingActLabelNames[,-2]
testActLabelNames<-testActLabelNames[,-2]






#obtain subject numbers

trainingSubj<-read.table("./Cdata/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
testSubj<-read.table("./Cdata/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
colnames(testSubj)[1]<-"Subject"
colnames(trainingSubj)[1]<-"Subject"

#combine activity, subject and feature data

testDatawLabels<-cbind(testActLabelNames[2],testSubj,testData2)
trainingDatawLabels<-cbind(trainingActLabelNames[2],trainingSubj,trainingData2)

#combine training and test data

DataAll<-rbind(trainingDatawLabels,testDatawLabels)

colnames(DataAll)[1]<-"Activity"
colnames(DataAll)[2]<-"Subject"

#Melt data into a dataframe with the measurements broken down on separate lines

#install.packages("reshape2")
library(reshape2)

mDataAll<-melt(DataAll,id=c("Activity","Subject"))


#Calculate the mean for each measurement for each activity-subject pair
#install.packages("plyr")
library(plyr)
meanset<-ddply(mDataAll,.(variable,Activity,Subject),summarise,Mean=mean(value))
colnames(meanset)[1]<-"Measurement"

#Reorder so dataset looks nice.
meanset<-meanset[order(as.character(meanset$Measurement),as.character(meanset$Activity),meanset$Subject),]

#Replace measurement names with more descriptive names


meanset$Measurement<- sub("BodyAcc-","BodyAccelerationSignal-",meanset$Measurement)
meanset$Measurement<- sub("GravityAcc-","GravityAccelerationSignal-",meanset$Measurement)
meanset$Measurement<- sub("BodyAccJerk-","BodyAccelJerkSignal-",meanset$Measurement)
meanset$Measurement<- sub("BodyGyro-","BodyAccelGyroSignal-",meanset$Measurement)

#Write dataset to table

write.table(meanset,file="GCRclassMeanSet.txt",row.name=FALSE) 


#write.table(unique(meanset$Measurement),file="MeasurementList5.txt")
#write.table(unique(meanset$Activity)),file="ActivityList.txt")

