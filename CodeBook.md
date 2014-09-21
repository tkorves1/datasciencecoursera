##Codebook- Human Activity Recognition Using Smartphones Dataset:
##Means for Measurements by Activity and Subject

### Measurement

The measured features.  There are four kinds of features measured:  Body Acceleration Signal (BodyAccelerationSignal), Body Acceleration Jerk Component (BodyAccelJerkSignal), Body Acceleration Gravity Component (BodyAccelGyroSignal), and Gravity Acceleration Signal (GravityAccelerationSignal)
A leading t indicates a feature with a time domain measurement; these were not Fourier transformed
A leading f indicates that the measurement variable is Fast Fourier Transformed 
Mag is short for magnitude
X, Y, Z indicates that the measurement is a raw signal in the X, Y , or Z axis
mean() indicates that the base feature is a mean of measurements
std() indicates that the base feature is a standard deviation of measurements
 
* "1" "fBodyAccelerationSignal-mean()-X"
* "2" "fBodyAccelerationSignal-mean()-Y"
* "3" "fBodyAccelerationSignal-mean()-Z"
* "4" "fBodyAccelerationSignal-std()-X"
* "5" "fBodyAccelerationSignal-std()-Y"
* "6" "fBodyAccelerationSignal-std()-Z"
* "7" "fBodyAccelJerkSignal-mean()-X"
* "8" "fBodyAccelJerkSignal-mean()-Y"
* "9" "fBodyAccelJerkSignal-mean()-Z"
* "10" "fBodyAccelJerkSignal-std()-X"
* "11" "fBodyAccelJerkSignal-std()-Y"
* "12" "fBodyAccelJerkSignal-std()-Z"
* "13" "fBodyAccMag-mean()"
* "14" "fBodyAccMag-std()"
* "15" "fBodyBodyAccJerkMag-mean()"
* "16" "fBodyBodyAccJerkMag-std()"
* "17" "fBodyBodyGyroJerkMag-mean()"
* "18" "fBodyBodyGyroJerkMag-std()"
* "19" "fBodyBodyGyroMag-mean()"
* "20" "fBodyBodyGyroMag-std()"
* "21" "fBodyAccelGyroSignal-mean()-X"
* "22" "fBodyAccelGyroSignal-mean()-Y"
* "23" "fBodyAccelGyroSignal-mean()-Z"
* "24" "fBodyAccelGyroSignal-std()-X"
* "25" "fBodyAccelGyroSignal-std()-Y"
* "26" "fBodyAccelGyroSignal-std()-Z"
* "27" "tBodyAccelerationSignal-mean()-X"
* "28" "tBodyAccelerationSignal-mean()-Y"
* "29" "tBodyAccelerationSignal-mean()-Z"
* "30" "tBodyAccelerationSignal-std()-X"
* "31" "tBodyAccelerationSignal-std()-Y"
* "32" "tBodyAccelerationSignal-std()-Z"
* "33" "tBodyAccelJerkSignal-mean()-X"
* b"34" "tBodyAccelJerkSignal-mean()-Y"
* "35" "tBodyAccelJerkSignal-mean()-Z"
* "36" "tBodyAccelJerkSignal-std()-X"
* "37" "tBodyAccelJerkSignal-std()-Y"
* "38" "tBodyAccelJerkSignal-std()-Z"
* "39" "tBodyAccJerkMag-mean()"
* "40" "tBodyAccJerkMag-std()"
* "41" "tBodyAccMag-mean()"
* "42" "tBodyAccMag-std()"
* "43" "tBodyAccelGyroSignal-mean()-X"
* "44" "tBodyAccelGyroSignal-mean()-Y"
* "45" "tBodyAccelGyroSignal-mean()-Z"
* "46" "tBodyAccelGyroSignal-std()-X"
* "47" "tBodyAccelGyroSignal-std()-Y"
* "48" "tBodyAccelGyroSignal-std()-Z"
* "49" "tBodyGyroJerk-mean()-X"
* "50" "tBodyGyroJerk-mean()-Y"
* "51" "tBodyGyroJerk-mean()-Z"
* "52" "tBodyGyroJerk-std()-X"
* "53" "tBodyGyroJerk-std()-Y"
* "54" "tBodyGyroJerk-std()-Z"
* "55" "tBodyGyroJerkMag-mean()"
* "56" "tBodyGyroJerkMag-std()"
* "57" "tBodyGyroMag-mean()"
* "58" "tBodyGyroMag-std()"
* "59" "tGravityAccelerationSignal-mean()-X"
* "60" "tGravityAccelerationSignal-mean()-Y"
* "61" "tGravityAccelerationSignal-mean()-Z"
* "62" "tGravityAccelerationSignal-std()-X"
* "63" "tGravityAccelerationSignal-std()-Y"
* "64" "tGravityAccelerationSignal-std()-Z"
* "65" "tGravityAccMag-mean()"
* "66" "tGravityAccMag-std()"

### Activity
* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING


### Subject
* Subject person number, 1 to 30

### Mean
* Mean of feature for the activity and subject listed
* The initial measures were time domain measures, from which means or standard deviations were taken. These were then normalized.  These normalized values are averaged for activity and subject here.   

