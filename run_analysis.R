  
#===================================================================================================
#              Coursera Specialization: 
#              Data Science - John Hopkins Universtity
#---------------------------------------------------------------------------------------------------
# Course:      getdata-006 - Getting and Cleaning Data   
# Assignment:  PROJECT 1 - TIDY DATA
# Data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Article:     [1] Davide Anguita, Alessandro Ghio, Luca Oneto, 
#               Xavier Parra and Jorge L. Reyes-Ortiz. 
#              Human Activity Recognition on Smartphones using a Multiclass
#              Hardware-Friendly Support Vector Machine. 
#              International Workshop of Ambient Assisted Living (IWAAL 2012). 
#              Vitoria-Gasteiz, Spain. Dec 2012
# Objective:   Create a tidy data set with the average of each mean and std variable 
#              for each activity and each subject.
# System:      ACER - Aspire 7250
#              AMD E-350 Processor 1.60 GHz
#              Windows 7 - 64 bit
#              R 3.1.1
#              RStudio 0.98.994
#
#
# Student:     Francisco Jaramillo 
#---------------------------------------------------------------------------------------------------
#2014.08.24 - FJ - Updated program replacing read.fwf by read.table. 
#                   Read table use significantly less RAM and the performance improved many times.
#2014.08.22 - FJ - Created program
#
#===================================================================================================






run_analysis <- function() 
{
  
     #setwd("C:/Users/Francisco/Desktop/Coursera/CoursProj1")
     #install.packages("data.table")
     #install.packages("stringr")
     #install.packages("plyr")
     #library(data.table)
     #library(stringr)
     #library(plyr)

##--------------------------------------------------------------------------------------------------                                                                                                         
## DOWNLOADING AND UNZIPING FILES
##-------------------------------------------------------------------------------------------------- 

#if(!file.exists("./CoursProj1")){dir.create("./CoursProj1")}
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl,destfile="./CoursProj1/data.zip")
#setwd("./CoursProj1/") 
#unzip("data.zip", overwrite=TRUE)


##-------------------------------------------------------------------------------------------------- 
## LOADING LABELS, CREATING LIST OF LABELS OF DATA TO BE EXTRACTED (TIDYLABELS)
## AND CREATING DESCRIPTIVE ACTIVITY NAMES
##-------------------------------------------------------------------------------------------------- 

#    rm(list=ls())



actlab <- data.table(activnum=1:6,activ=c("Walking","Walking Upstairs","Walking Downstairs"
                                          ,"Sitting","Standing","Laying"))
datalab <- read.table("./UCI HAR Dataset/features.txt", col.names=c("number","label"))
meanlab <- subset(datalab, grepl("-mean()", datalab$label, fixed=TRUE))
stdlab <- subset(datalab, grepl("-std()", datalab$label, fixed=TRUE))
tidylabels <- rbind(meanlab,stdlab )
tidylabels <- arrange(tidylabels,number)


##-------------------------------------------------------------------------------------------------- 
# CREATING DESCRIPTIVE VARIABLE NAMES AND ADDING THEM TO TIDYLABELS
##-------------------------------------------------------------------------------------------------- 


variablenames <- tidylabels[,2]


variablenames <- 
     str_replace_all(
          variablenames, "tGravityAccMag", "GravityAccelerometerMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "tGravityAcc", "GravityAccelerometerSignal")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyGyroMag", "BodyGyroscopeMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyGyroJerkMag", "BodyGyroscopeJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyGyroJerk", "BodyGyroscopeJerk")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyGyro", "BodyGyroscopeSignal")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyAccMag", "BodyAccelerometerMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyAccJerkMag", "BodyAccelerometerJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyAccJerk", "BodyAccelerometerJerk")
variablenames <- 
     str_replace_all(
          variablenames, "tBodyAcc", "BodyAccelerometerSignal")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyGyroMag", "TransformedBodyGyroscopeMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyGyroJerkMag", "TransformedBodyGyroscopeJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyGyro", "TransformedBodyGyroscopeSignal")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyBodyGyroMag", "TransformedBodyBodyGyroscopeMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyBodyGyroJerkMag", "TransformedBodyBodyGyroscopeJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyBodyAccJerkMag", "TransformedBodyBodyAccelerometerJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyAccMag", "TransformedBodyAccelerometerMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyAccJerkMag", "TransformedBodyAccelerometerJerkMagnitude")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyAccJerk", "TransformedBodyAccelerometerJerk")
variablenames <- 
     str_replace_all(
          variablenames, "fBodyAcc", "TransformedBodyAccelerometerSignal")
variablenames <- 
     str_replace_all(
          variablenames, "std", "StandardDeviation")
variablenames <- 
     str_replace_all(
          variablenames, "mean", "Mean")
variablenames <- str_replace_all(variablenames, "[[:punct:]]", "")


tidylabels <- cbind(tidylabels,variablenames )


##-------------------------------------------------------------------------------------------------- 
## CREATING AND EXTRACTSET OF DATA TO BE EXTRACTED
## LOADING ALL TESTRAWDATA AND TRAINRAWDATA
## KEEPING THE RELEVANT TESTDATA AND TRAINDATA
## MERGING DATA AND ADDING DESCRIPTIVE LABELS
##-------------------------------------------------------------------------------------------------- 


extractset <- c(tidylabels$number)

testrawdata <- read.table("./UCI HAR Dataset/test/x_test.txt")
colnames(testrawdata) <- datalab[,2]
testdata <- testrawdata[,tidylabels$number[]]
testsubj <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("subject"))
testact <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("activnum"))
testdata <- cbind(testdata,testsubj,testact )
testdata <- merge(testdata,actlab,by.x="activnum",by.y="activnum",all=FALSE)

trainrawdata <- read.table("./UCI HAR Dataset/train/x_train.txt")
colnames(trainrawdata) <- datalab[,2]
traindata <- trainrawdata[,tidylabels$number[]]
trainsubj <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("subject"))
trainact <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("activnum"))
traindata <- cbind(traindata,trainsubj,trainact )
traindata <- merge(traindata,actlab,by.x="activnum",by.y="activnum",all=FALSE)

data <- rbind(testdata,traindata)

tidylabels<- t(tidylabels)
tidylabels <- cbind(c("","activnum","ActivityCode")
                    ,tidylabels,c("","subject","SubjectCode"),c("","activ","Activity"))
colnames(tidylabels) <- tidylabels[3,]
tidylabels <- data.frame(tidylabels,stringsAsFactors=FALSE)
#data <- rbind(tidylabels,data)
colnames(data) <-tidylabels[3,]


##-------------------------------------------------------------------------------------------------- 
## CREATING TIDY DATA AS:
## THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
##-------------------------------------------------------------------------------------------------- 


tidydata <- numeric()

tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerSignalStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerSignalStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerSignalStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerSignalStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeSignalStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeSignalStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "GravityAccelerometerMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(GravityAccelerometerMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyAccelerometerJerkMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyAccelerometerJerkMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "BodyGyroscopeJerkMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(BodyGyroscopeJerkMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerSignalStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerSignalStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerJerkStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerJerkStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalMeanX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalMeanX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalMeanY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalMeanY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalMeanZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalMeanZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalStandardDeviationX")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalStandardDeviationX))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalStandardDeviationY")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalStandardDeviationY))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyGyroscopeSignalStandardDeviationZ")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyGyroscopeSignalStandardDeviationZ))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyAccelerometerMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyAccelerometerMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyAccelerometerJerkMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyBodyAccelerometerJerkMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyAccelerometerJerkMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
          ,summarize,Mean = mean(TransformedBodyBodyAccelerometerJerkMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyGyroscopeMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyBodyGyroscopeMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyGyroscopeMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyBodyGyroscopeMagnitudeStandardDeviation))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyGyroscopeJerkMagnitudeMean")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyBodyGyroscopeJerkMagnitudeMean))))
tidydata <- rbind(tidydata,cbind(Variable=c(
     "TransformedBodyBodyGyroscopeJerkMagnitudeStandardDeviation")
     ,ddply(data, .(SubjectCode, Activity)
            , summarize,Mean = mean(TransformedBodyBodyGyroscopeJerkMagnitudeStandardDeviation))))


    write.table(tidydata, file = "./tidydata.txt", row.name=FALSE)

#print(head(tidydata))
#print(dim(tidydata))

}
