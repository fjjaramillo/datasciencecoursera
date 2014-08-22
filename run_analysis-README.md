***
#README - run_analysis.R 
###*Coursera - getdata-006 - Project 1 - Tidy Data*
####*Francisco Jaramillo*
#####*Friday, August 22, 2014*
***


##1. SCRIPT DESIGN -- HOW THE SCRIPT WORKS?
***
Because of CPU limitations this program starts by declaring a limit of rows to upload from every one of the raw data tables (n<- 100). The program  can be updated to run for the whole raw data just by making n <- -1.


***
####1.1 Loading labels, creating list of labels of data to be extracted (tidylabels) and creating descriptive activity names

Descriptive activity labels are created on **actlab (names in bold correspond to objects)** by assigning a description to every activity code.
  
  
All the labels are loaded on **datalab**. 


The relevant measurements are identified on **tidylabels** by detecting all the measurements containing  the strings -mean() or -std() on their label.   
   

***
####1.2 Creating descriptive variable names and adding them to tidylabels

**variablenames** is loaded with the relevant measures labels based on the list on **tidylabels**, and then the measurement abbreviated codes on **variablenames**  are substituted using str_replace_all as per the Code Book "Variables Descriptive Names List" (List 4 in section 2.2.2 of this README)

***
####1.3 Identifying the columns of raw data to be extracted

**extractset** is a vector containing the identification numbers of the columns of relevant measurements.
 
***
####1.4 Loading all TESTRAWDATA and TRAINRAWDATA; and integrating activity and subjects data
     
"Activity" data is loaded on **testact** and **trainact**

"Subjects" data is loaded on **testsubj** and **trainsubj**


All the raw data (allowed by the row limiter "n") is loaded into **testdata** and **traindata**


Only measurements identified on **extractset** are kept


**testdata** and **traindata** are combined and merged to integrate in the same tables the relevant measurements and the 
corresponding subjects, activity codes and activity descriptive labels. 


Then **testdata** and **traindata** are combined together into **data**;  and then, the measurements descriptive labels are added to **data** as column names.

***
####1.5 Creating tidy data as: the average of each variable for each activity and each subject

**tidydata** is built one relevant variable at a time. ddply is used to subgroup every variable data by activity and subject while calculating the mean by those subgroups. 


Then, those results are combined to the variable label using cbing. 


Finally, all that tidydata-row-set (variable-activity-subject-mean) is combined as rows to the **tidydata** data frame using rbind.


After the data for each of the 66 relevant measurements is sub grouped by activities and subjects, the means are calculated, and is all combined by rows; the **tidydata** table is complete and ready to print.  






---
 
##2. CODE BOOK
***
###2.1 Information attached to the raw data: (files: README.txt and features_info.txt on unzipped folder: ./UCI HAR Dataset/)

####2.1.1 Human Activity Recognition Using Smartphones Dataset (file: README.txt)

Version 1.0      


Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
***

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

>For each record it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

>The dataset includes the following files:


- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

>Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

>License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


***
####2.1.2 Feature Selection for the Human Activity Recognition Using Smartphones Dataset Research (file: features_info.txt)



The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'


***
###2.2 Coursera - Getdata-006 - Tidy Data Project

####2.2.1 Variables Selected

As per the objectives of the project "only the measurements on the mean and standard deviation for each measurement" are required.
So, on the program, there is a piece of logic that searches every variable label and identify all the variables (data columns) which contain either -mean() or - std(). Those are the relevant measures for the Tidy Data Project
Here is a list of the relevant measurements used for the project:

>List 1: List of the relevant measurements used:

|ColumnNumber|VariableLabel|
|:-------:|-------|
|1|tBodyAcc-mean()-X|
|2|tBodyAcc-mean()-Y|
|3|tBodyAcc-mean()-Z|
|4|tBodyAcc-std()-X|
|5|tBodyAcc-std()-Y|
|6|tBodyAcc-std()-Z|
|41|tGravityAcc-mean()-X|
|42|tGravityAcc-mean()-Y|
|43|tGravityAcc-mean()-Z|
|44|tGravityAcc-std()-X|
|45|tGravityAcc-std()-Y|
|46|tGravityAcc-std()-Z|
|81|tBodyAccJerk-mean()-X|
|82|tBodyAccJerk-mean()-Y|
|83|tBodyAccJerk-mean()-Z|
|84|tBodyAccJerk-std()-X|
|85|tBodyAccJerk-std()-Y|
|86|tBodyAccJerk-std()-Z|
|121|tBodyGyro-mean()-X|
|122|tBodyGyro-mean()-Y|
|123|tBodyGyro-mean()-Z|
|124|tBodyGyro-std()-X|
|125|tBodyGyro-std()-Y|
|126|tBodyGyro-std()-Z|
|161|tBodyGyroJerk-mean()-X|
|162|tBodyGyroJerk-mean()-Y|
|163|tBodyGyroJerk-mean()-Z|
|164|tBodyGyroJerk-std()-X|
|165|tBodyGyroJerk-std()-Y|
|166|tBodyGyroJerk-std()-Z|
|201|tBodyAccMag-mean()|
|202|tBodyAccMag-std()|
|214|tGravityAccMag-mean()|
|215|tGravityAccMag-std()|
|227|tBodyAccJerkMag-mean()|
|228|tBodyAccJerkMag-std()|
|240|tBodyGyroMag-mean()|
|241|tBodyGyroMag-std()|
|253|tBodyGyroJerkMag-mean()|
|254|tBodyGyroJerkMag-std()|
|266|fBodyAcc-mean()-X|
|267|fBodyAcc-mean()-Y|
|268|fBodyAcc-mean()-Z|
|269|fBodyAcc-std()-X|
|270|fBodyAcc-std()-Y|
|271|fBodyAcc-std()-Z|
|345|fBodyAccJerk-mean()-X|
|346|fBodyAccJerk-mean()-Y|
|347|fBodyAccJerk-mean()-Z|
|348|fBodyAccJerk-std()-X|
|349|fBodyAccJerk-std()-Y|
|350|fBodyAccJerk-std()-Z|
|424|fBodyGyro-mean()-X|
|425|fBodyGyro-mean()-Y|
|426|fBodyGyro-mean()-Z|
|427|fBodyGyro-std()-X|
|428|fBodyGyro-std()-Y|
|429|fBodyGyro-std()-Z|
|503|fBodyAccMag-mean()|
|504|fBodyAccMag-std()|
|516|fBodyBodyAccJerkMag-mean()|
|517|fBodyBodyAccJerkMag-std()|
|529|fBodyBodyGyroMag-mean()|
|530|fBodyBodyGyroMag-std()|
|542|fBodyBodyGyroJerkMag-mean()|
|543|fBodyBodyGyroJerkMag-std()|



*** 
####2.2.2 Descriptive Variable Names Selected for the Relevant Variables

Another requirement of the project is to "Appropriately labels the data set with descriptive variable names".    

In order to meet this requirement, the description of variables of the "Human Activity Recognition Using Smartphones Data set Research" (Section 2.1.1) has been read and interpreted. An accurate description of the variables would require many words. Just as an intermediate step to select the descriptive variable names, a long description has been selected for every variable.     

Trying to find accurate descriptive variable names for such a particular and specialized measurements; that were also short enough to make the Tidy Data easily readable is quite a challenge.     

In order to satisfy the requirements of the project, descriptiveness has prevailed over name size and tidy data readability.   

Just for reference, the lists created to select the descriptive names will follow:

>List 2: List of generic variables original identification codes Vs variables long descriptive names:

|Raw Data Generic Original Label|Long Description|
|-------|-------|
|tGravityAccMag|Time Domain Based - Gravity Accelerometer Calculated Magnitude|
|tGravityAcc|Time Domain Based - Gravity Accelerometer Conditioned Signal|
|tBodyGyroMag|Time Domain Based - Body Gyroscope Calculated Magnitude|
|tBodyGyroJerkMag|Time Domain Based - Body Gyroscope Derived Jerk Calculated Magnitude|
|tBodyGyroJerk|Time Domain Based - Body Gyroscope Derived Jerk|
|tBodyGyro|Time Domain Based - Body Gyroscope Signal|
|tBodyAccMag|Time Domain Based - Body Accelerometer  Calculated Magnitude|
|tBodyAccJerkMag|Time Domain Based - Body Accelerometer Derived Jerk Calculated Magnitude|
|tBodyAccJerk|Time Domain Based - Body Accelerometer Derived Jerk|
|tBodyAcc|Time Domain Based - Body Accelerometer Conditioned Signal|
|fBodyGyroMag|Fast Fourier Transformed - Body Gyroscope Calculated Magnitude|
|fBodyGyroJerkMag|Fast Fourier Transformed - Body Gyroscope Derived Jerk Calculated Magnitude|
|fBodyGyro|Fast Fourier Transformed - Body Gyroscope Signal|
|fBodyBodyGyroMag|Fast Fourier Transformed - Body Body Gyroscope Calculated Magnitude|
|fBodyBodyGyroJerkMag|Fast Fourier Transformed - Body Body Gyroscope Derived Jerk Calculated Magnitude|
|fBodyBodyAccJerkMag|Fast Fourier Transformed - Body Body Accelerometer Derived Jerk Calculated Magnitude|
|fBodyAccMag|Fast Fourier Transformed - Body Accelerometer  Calculated Magnitude|
|fBodyAccJerkMag|Fast Fourier Transformed - Body Accelerometer Derived Jerk Calculated Magnitude|
|fBodyAccJerk|Fast Fourier Transformed - Body Accelerometer Derived Jerk|
|fBodyAcc|Fast Fourier Transformed - Body Accelerometer Conditioned Signal|

 

>List 3: List of generic variables original identification codes Vs selected variables descriptive names:

|Raw Data Generic Original Label|Descriptive Name|
|-------|-------|
|tGravityAccMag|GravityAccelerometerMagnitude|
|tGravityAcc|GravityAccelerometerSignal|
|tBodyGyroMag|BodyGyroscopeMagnitude|
|tBodyGyroJerkMag|BodyGyroscopeJerkMagnitude|
|tBodyGyroJerk|BodyGyroscopeJerk|
|tBodyGyro|BodyGyroscopeSignal|
|tBodyAccMag|BodyAccelerometerMagnitude|
|tBodyAccJerkMag|BodyAccelerometerJerkMagnitude|
|tBodyAccJerk|BodyAccelerometerJerk|
|tBodyAcc|BodyAccelerometerSignal|
|fBodyGyroMag|TransformedBodyGyroscopeMagnitude|
|fBodyGyroJerkMag|TransformedBodyGyroscopeJerkMagnitude|
|fBodyGyro|TransformedBodyGyroscopeSignal|
|fBodyBodyGyroMag|TransformedBodyBodyGyroscopeMagnitude|
|fBodyBodyGyroJerkMag|TransformedBodyBodyGyroscopeJerkMagnitude|
|fBodyBodyAccJerkMag|TransformedBodyBodyAccelerometerJerkMagnitude|
|fBodyAccMag|TransformedBodyAccelerometerMagnitude|
|fBodyAccJerkMag|TransformedBodyAccelerometerJerkMagnitude|
|fBodyAccJerk|TransformedBodyAccelerometerJerk|
|fBodyAcc|TransformedBodyAccelerometerSignal|


>List 4: List of specific variables original identification codes Vs variables descriptive names for the 66 variables used on the program:

|Original Variable Label|Descriptive Name|
|-------|-------|
|tBodyAcc-mean()-X|BodyAccelerometerSignalMeanX|
|tBodyAcc-mean()-Y|BodyAccelerometerSignalMeanY|
|tBodyAcc-mean()-Z|BodyAccelerometerSignalMeanZ|
|tBodyAcc-std()-X|BodyAccelerometerSignalStandardDeviationX|
|tBodyAcc-std()-Y|BodyAccelerometerSignalStandardDeviationY|
|tBodyAcc-std()-Z|BodyAccelerometerSignalStandardDeviationZ|
|tGravityAcc-mean()-X|GravityAccelerometerSignalMeanX|
|tGravityAcc-mean()-Y|GravityAccelerometerSignalMeanY|
|tGravityAcc-mean()-Z|GravityAccelerometerSignalMeanZ|
|tGravityAcc-std()-X|GravityAccelerometerSignalStandardDeviationX|
|tGravityAcc-std()-Y|GravityAccelerometerSignalStandardDeviationY|
|tGravityAcc-std()-Z|GravityAccelerometerSignalStandardDeviationZ|
|tBodyAccJerk-mean()-X|BodyAccelerometerJerkMeanX|
|tBodyAccJerk-mean()-Y|BodyAccelerometerJerkMeanY|
|tBodyAccJerk-mean()-Z|BodyAccelerometerJerkMeanZ|
|tBodyAccJerk-std()-X|BodyAccelerometerJerkStandardDeviationX|
|tBodyAccJerk-std()-Y|BodyAccelerometerJerkStandardDeviationY|
|tBodyAccJerk-std()-Z|BodyAccelerometerJerkStandardDeviationZ|
|tBodyGyro-mean()-X|BodyGyroscopeSignalMeanX|
|tBodyGyro-mean()-Y|BodyGyroscopeSignalMeanY|
|tBodyGyro-mean()-Z|BodyGyroscopeSignalMeanZ|
|tBodyGyro-std()-X|BodyGyroscopeSignalStandardDeviationX|
|tBodyGyro-std()-Y|BodyGyroscopeSignalStandardDeviationY|
|tBodyGyro-std()-Z|BodyGyroscopeSignalStandardDeviationZ|
|tBodyGyroJerk-mean()-X|BodyGyroscopeJerkMeanX|
|tBodyGyroJerk-mean()-Y|BodyGyroscopeJerkMeanY|
|tBodyGyroJerk-mean()-Z|BodyGyroscopeJerkMeanZ|
|tBodyGyroJerk-std()-X|BodyGyroscopeJerkStandardDeviationX|
|tBodyGyroJerk-std()-Y|BodyGyroscopeJerkStandardDeviationY|
|tBodyGyroJerk-std()-Z|BodyGyroscopeJerkStandardDeviationZ|
|tBodyAccMag-mean()|BodyAccelerometerMagnitudeMean|
|tBodyAccMag-std()|BodyAccelerometerMagnitudeStandardDeviation|
|tGravityAccMag-mean()|GravityAccelerometerMagnitudeMean|
|tGravityAccMag-std()|GravityAccelerometerMagnitudeStandardDeviation|
|tBodyAccJerkMag-mean()|BodyAccelerometerJerkMagnitudeMean|
|tBodyAccJerkMag-std()|BodyAccelerometerJerkMagnitudeStandardDeviation|
|tBodyGyroMag-mean()|BodyGyroscopeMagnitudeMean|
|tBodyGyroMag-std()|BodyGyroscopeMagnitudeStandardDeviation|
|tBodyGyroJerkMag-mean()|BodyGyroscopeJerkMagnitudeMean|
|tBodyGyroJerkMag-std()|BodyGyroscopeJerkMagnitudeStandardDeviation|
|fBodyAcc-mean()-X|TransformedBodyAccelerometerSignalMeanX|
|fBodyAcc-mean()-Y|TransformedBodyAccelerometerSignalMeanY|
|fBodyAcc-mean()-Z|TransformedBodyAccelerometerSignalMeanZ|
|fBodyAcc-std()-X|TransformedBodyAccelerometerSignalStandardDeviationX|
|fBodyAcc-std()-Y|TransformedBodyAccelerometerSignalStandardDeviationY|
|fBodyAcc-std()-Z|TransformedBodyAccelerometerSignalStandardDeviationZ|
|fBodyAccJerk-mean()-X|TransformedBodyAccelerometerJerkMeanX|
|fBodyAccJerk-mean()-Y|TransformedBodyAccelerometerJerkMeanY|
|fBodyAccJerk-mean()-Z|TransformedBodyAccelerometerJerkMeanZ|
|fBodyAccJerk-std()-X|TransformedBodyAccelerometerJerkStandardDeviationX|
|fBodyAccJerk-std()-Y|TransformedBodyAccelerometerJerkStandardDeviationY|
|fBodyAccJerk-std()-Z|TransformedBodyAccelerometerJerkStandardDeviationZ|
|fBodyGyro-mean()-X|TransformedBodyGyroscopeSignalMeanX|
|fBodyGyro-mean()-Y|TransformedBodyGyroscopeSignalMeanY|
|fBodyGyro-mean()-Z|TransformedBodyGyroscopeSignalMeanZ|
|fBodyGyro-std()-X|TransformedBodyGyroscopeSignalStandardDeviationX|
|fBodyGyro-std()-Y|TransformedBodyGyroscopeSignalStandardDeviationY|
|fBodyGyro-std()-Z|TransformedBodyGyroscopeSignalStandardDeviationZ|
|fBodyAccMag-mean()|TransformedBodyAccelerometerMagnitudeMean|
|fBodyAccMag-std()|TransformedBodyAccelerometerMagnitudeStandardDeviation|
|fBodyBodyAccJerkMag-mean()|TransformedBodyBodyAccelerometerJerkMagnitudeMean|
|fBodyBodyAccJerkMag-std()|TransformedBodyBodyAccelerometerJerkMagnitudeStandardDeviation|
|fBodyBodyGyroMag-mean()|TransformedBodyBodyGyroscopeMagnitudeMean|
|fBodyBodyGyroMag-std()|TransformedBodyBodyGyroscopeMagnitudeStandardDeviation|
|fBodyBodyGyroJerkMag-mean()|TransformedBodyBodyGyroscopeJerkMagnitudeMean|
|fBodyBodyGyroJerkMag-std()|TransformedBodyBodyGyroscopeJerkMagnitudeStandardDeviation|


***
####2.2.3 Descriptive Activity Names Selected

Another of the requirements of the project is to "Uses descriptive activity names to name the activities in the data set". The following is the list of descriptive activity names by the original activity codes:

>List 5: List of descriptive activity names by activity code:


|Activity Code|Descriptive Activity Name|
|:---:|---|
|1|Walking|
|2|Walking Upstairs|
|3|Walking Downstairs|
|4|Sitting|
|5|Standing|
|6|Laying|
