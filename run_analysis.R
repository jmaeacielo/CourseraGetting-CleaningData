## Download and unzip the dataset
if (!file.exists("UCI HAR Dataset")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile="##directory/UCI HAR Dataset.zip", method="curl") 
}  
if (!file.exists("UCI HAR Dataset.zip")) { 
  unzip("UCI HAR Dataset") 
}

setwd("./UCI HAR Dataset/")

library(dplyr)

## Read train data
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/Y_train.txt")
subj_train <- read.table("./train/subject_train.txt")
train <- cbind(x_train, y_train, subj_train)

## Read test data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/Y_test.txt")
subj_test <- read.table("./test/subject_test.txt")
test <- cbind(x_test, y_test, subj_test)

## Load activity labels
labels <- read.table("./activity_labels.txt")
trainlabels <- read.table("./train/Y_train.txt")
testlabels <- read.table("./test/Y_test.txt")

## Combine IDs of activities with its labels and append labels
trainlabels$V1 <- labels[trainlabels$V1, 2]
testlabels$V1 <- labels[testlabels$V1, 2]
labelsAll <- rbind(trainlabels, testlabels)
colnames(labelsAll) <- c("activity")
labelsAll[, "activity"] <- as.factor(labelsAll[, "activity"])

## Read subjects
trainSubjectIDs <- read.table("./train/subject_train.txt")
testSubjectIDs <- read.table("./test/subject_test.txt")
subjectAll <- rbind(trainSubjectIDs, testSubjectIDs)
colnames(subjectAll) <- c("subject")

## Read features
headersDF <- read.table("./features.txt")

## Task 1: Merge and append datasets
master <- rbind(train, test)
colnames(master) <- headersDF$V2

## Task 2: Extract only measurements on mean and SD
selected_var <- headersDF[grep("mean\\(\\)|std\\(\\)", headersDF[,2]),]
master <- master[,selected_var[,1]]

## Add subject and activity columns
master <- do.call("cbind", list(master, select(labelsAll, "activity"), subjectAll))

## Task 3: Uses descriptive activity names to name the activities in the data set
levels(master$activity) <- list(lay="LAYING", sit="SITTING", stand="STANDING", walk="WALKING", 
                                 walk_down="WALKING_DOWNSTAIRS", walk_up="WALKING_UPSTAIRS")

## Task 4: Appropriately label the data set with clear and readable descriptive variable names
RenameCol <- function(name) {
  newName <- gsub("^t", "time", name)
  newName <- gsub("^f", "freq", newName)
  newName <- gsub("([A][B][G][J][M])", "\\.\\1", newName)
  newName <- gsub("Acc", "accelerometer", newName)
  newName <- gsub("Gyro", "gyroscope", newName)
  newName <- gsub("Mag", "magnitude", newName)
  newName <- gsub("\\-", "\\.", newName)
  newName <- gsub("\\(\\)", "", newName)
  tolower(newName)
}

names(master) <- RenameCol(names(master))

## Task 5: Create a second, independent tidy data set with the average for each variable for each activity and subject
master$subject <- as.factor(master$subject) ## Turns subjects into factor

library(reshape2)

tidydata <- melt(master, id=c("subject", "activity"))
meantidydata <- dcast(tidydata, subject + activity ~ variable, mean)

## Tidy does it

write.table(meantidydata, "tidy.txt", row.names = FALSE, quote = FALSE)