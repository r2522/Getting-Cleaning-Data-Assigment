# 1. Load required packages: 
library(dplyr)

# 2. Downloading Data:

setwd("~/Desktop/Coursera")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "./getdata_projectfiles_UCI HAR Dataset.zip"
UCI <- "./UCI HAR Dataset"

if (!file.exists(UCI)) {
  download.file(fileUrl, file, method = "curl")
  unzip(file, overwrite = T, exdir = "./")
}

# 3. Features & Activities:
Features<-read.table("~/Desktop/Coursera/UCI HAR Dataset/features.txt", col.names = c("n","Functions"))
Activities <- read.table("~/Desktop/Coursera/UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "Kind"))

# 4. Test Data:
XTest<- read.table("~/Desktop/Coursera/UCI HAR Dataset/test/X_test.txt", col.names = Features$Functions)
YTest<- read.table("~/Desktop/Coursera/UCI HAR Dataset/test/Y_test.txt", col.names = c("Activity"))
SubjectTest <-read.table("~/Desktop/Coursera/UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

# 5. Train Data:
XTrain<- read.table("~/Desktop/Coursera/UCI HAR Dataset/train/X_train.txt",col.names = Features$Functions )
YTrain<- read.table("~/Desktop/Coursera/UCI HAR Dataset/train/Y_train.txt", col.names = "Activity")
SubjectTrain <-read.table("~/Desktop/Coursera/UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

# 6. Step 1: Merges the training and the test sets to create one data set.
X <- rbind (XTrain, XTest)
Y <- rbind (YTrain, YTest)
Subject <- rbind (SubjectTrain, SubjectTest)
Merged <- cbind (Subject, Y, X)

# 7. Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
Tidy <- select (Merged, Subject, Activity, contains ("mean"), contains ("std"))

# 8. Step 3: Uses descriptive activity names to name the activities in the data set.
Tidy$Activity <- Activities[Tidy$Activity, 2]

# 9. Step 4: Appropriately labels the data set with descriptive variable names.
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "STD", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

# 10. Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject:

Final <- Tidy %>%
  group_by(Subject, Activity) 
  
# Export Data  
write.table(Final, "~/Desktop/Coursera/FinalData.txt", row.name=FALSE)







































