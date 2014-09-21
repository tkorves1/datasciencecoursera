##README
##Methods Used to Create "Human Activity Recognition Using Smartphones Dataset: Means for Measurements by Activity and Subject"


###This script creates some summary data from the dataset called Human Activity Recognition Using Smartphones Datase.  It selects the mean and standard deviation measurements for each of the features measured in the dataset and calculates means for each of these for each activity-human subject pair.

Note: This script assumes that the packages reshape2 and plyr have been installed.  

###Download the data files from the URL and unzip

```{r}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(! file.exists("Cdata")){dir.create("Cdata")
}
temp<-tempfile()
download.file(fileUrl,temp)
for (i in temp){
  unzip(i,exdir="./Cdata")
}
```

###This section reads the feature data into a df, and labels the colms

Read in the dataset containing measurements for the features
```{r}
testData<-read.table("./Cdata/UCI HAR Dataset/test/X_test.txt",header=FALSE)
trainingData<-read.table("./Cdata/UCI HAR Dataset/train/X_train.txt",header=FALSE)
```

Read in the features, which will become the column names, and assign these as colm names

```{r}
features<-read.table("./Cdata/UCI HAR Dataset/features.txt")
featureNames<-as.character(features$V2)
colnames(testData)<-c(featureNames)
colnames(trainingData)<-c(featureNames)
```


###This section reduces the data sets to mean and std of features only, based on the presence or absence of the word mean and std
The project instructions were unclear as to whether to include mean and std dev for measurements along each X, Y, Z, axis.
I chose to include all, but excluded those for "MeanFreq" as it is unclear that these are really mean features and belong in this category

First create a dataframe with feature names

```{r}
features1<-data.frame(featureNames,stringsAsFactors=FALSE)
```

Get true/false on whether contain "mean", "std"
grepl creates a true false vector based on the presence of the indicated string

```{r}
features1$mean<-grepl(("mean"),features1$featureNames)
features1$std<-grepl(("std"),features1$featureNames)
```

Include the measurement names where either true

```{r}
featuresToInclude<-features1$featureNames[features1$mean==TRUE|features1$std==TRUE]
```

Reduce data set to colms that are in the features to include set

```{r}
testData2<-testData[,colnames(testData) %in% featuresToInclude]
trainingData2<-trainingData[,colnames(trainingData) %in% featuresToInclude]
```


###This section reads in activity numbers corresponding to the measurement dataset, and replaces the numbers with activity names
To preserve the order of the activity numbers after merging, the numbers are initially ordered and resorted according to that order after the merge


Read in activity data labels

```{r}
trainingActLabels<-read.table("./Cdata/UCI HAR Dataset/train/y_train.txt",header=FALSE)
testActLabels<-read.table("./Cdata/UCI HAR Dataset/test/y_test.txt",header=FALSE)
```

Add order to these so that can reorder correctly after merge to line up with measurement data

```{r}
trainingActLabels$order<-1:nrow(trainingActLabels)
testActLabels$order<-1:nrow(testActLabels)
```


Read in file that has the descriptive names corresponding to the activity numbers

```{r}
ActivityLabels<-read.table("./Cdata/UCI HAR Dataset/activity_labels.txt",header=FALSE)
colnames(ActivityLabels)[2]<-"Activity"
```


Merge activity names with activity label numbers

```{r}
trainingActLabelNames<-merge(trainingActLabels,ActivityLabels,by="V1")
testActLabelNames<-merge(testActLabels,ActivityLabels,by="V1")
```

Reorder the Activity number according to the original order, so that they will correctly line up with the measruement data

```{r}
trainingActLabelNames<-trainingActLabelNames[order(trainingActLabelNames$order),]
testActLabelNames<-testActLabelNames[order(testActLabelNames$order),]
```


Remove the order variable
```{r}
trainingActLabelNames<-trainingActLabelNames[,-2]
testActLabelNames<-testActLabelNames[,-2]
```


###This section obtains the subjet numbers, and then combines the subject, activity and feature data for training and test sets into one dataframe.

Obtain subject numbers

```{r}
trainingSubj<-read.table("./Cdata/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
testSubj<-read.table("./Cdata/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
colnames(testSubj)[1]<-"Subject"
colnames(trainingSubj)[1]<-"Subject"
```


Combine activity, subject and feature data

```{r}
testDatawLabels<-cbind(testActLabelNames[2],testSubj,testData2)
trainingDatawLabels<-cbind(trainingActLabelNames[2],trainingSubj,trainingData2)
```

Combine training and test data


```{r}
DataAll<-rbind(trainingDatawLabels,testDatawLabels)

colnames(DataAll)[1]<-"Activity"
colnames(DataAll)[2]<-"Subject"
```

###This section creates the table of means for each measurement for each activity-subject pair, replaces feature measurement names with more descriptive names, and and writes it to a file.

Melt data into a dataframe with the different measurement variables listed in a single colm

```{r}
#install.packages("reshape2")
library(reshape2)

mDataAll<-melt(DataAll,id=c("Activity","Subject"))
```


Then calculate the mean for each measurement for each activity-subject pair using ddply

```{r}
#install.packages("plyr")
library(plyr)
meanset<-ddply(mDataAll,.(variable,Activity,Subject),summarise,Mean=mean(value))
colnames(meanset)[1]<-"Measurement"
```

Reorder so dataset looks nice.

```{r}
meanset<-meanset[order(as.character(meanset$Measurement),as.character(meanset$Activity),meanset$Subject),]
```

Replace measurement names with more descriptive names

```{r}
meanset$Measurement<- sub("BodyAcc-","BodyAccelerationSignal-",meanset$Measurement)
meanset$Measurement<- sub("GravityAcc-","GravityAccelerationSignal-",meanset$Measurement)
meanset$Measurement<- sub("BodyAccJerk-","BodyAccelJerkSignal-",meanset$Measurement)
meanset$Measurement<- sub("BodyGyro-","BodyAccelGyroSignal-",meanset$Measurement)
```

Write table

```{r}
write.table(meanset,file="GCRclassMeanSet.txt",row.name=FALSE) 
```

