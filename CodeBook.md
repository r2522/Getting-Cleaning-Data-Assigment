The “run_analysis.R” script was written as a result of the “Cleaning and Getting Data” Course (final project). It performs the data obtaining and preparation, followed by 5 required steps to accomplish the project.

1. Load required packages: 
Loaded the “dplyr” package

2. Downloading Data:
Dataset downloaded from the internet in a “zip” format and stored in my User’s Desktop, in “Coursera” Directory

3. Unzip the Dataset:
Unzip the Dataset and stored it in the previously described “Coursera” Directory. The result was a “UCI HAR Dataset” Folder, with 2 Folders inside (test & train) and 4 “.txt” files.

4. Features & Activities:
Assign data to Features & Activities variables:
-	Features <- features.txt: 561 rows, 2 columns.
Are the names of the variables; some of them were measured with an accelerometer (“Acc”) or gyroscope (“Gyro”). Others were the calculated results from these measures.
-	Activities <- activity_labels.txt: 6 rows, 2 columns.
Is the list of activities codes (“Activity”), from 1 to 6, and their activity description (“Kind”).

5. Test Data:
Assign data to “test Folder” files (inside UCI HAR Dataset Folder):
-	XTest <- X_test.txt: 2947 rows, 561 columns.
Contains test data
-	YTest <- Y_test.txt: 2947 rows, 1 column.
Contains the activities codes of XTest data
-	SubjectTest <- subject_test.txt: 2947 rows, 1 column.
Contains the test subjects (30% of a total of 30 volunteers) of XTest data.
 
6. Train data:
Assign data to “train Folder” files (inside UCI HAR Dataset Folder):
-	XTrain <- X_test.txt: 7352 rows, 561 columns.
Contains train data
-	YTrain <- Y_test.txt: 7352 rows, 1 column.
Contains the activities codes of the XTrain data
-	SubjectTrain <- subject_test.txt: 7352 rows, 1 column.
Contains the test subjects (70% of a total of 30 volunteers) of XTrain data.


7. Step 1: Merges the training and the test sets to create one data set.
X <- rbind (XTrain, XTest). 10299 rows, 561 columns.
Created by merging XTrain and XTest using rbind() function.


Y <- rbind (YTrain, YTest). 10299 rows, 1 column.
Created by merging YTrain and YTest using rbind() function.

Subject <- rbind (SubjectTrain, SubjectTest).
Created by merging SubjectTrain and SubjectTest using rbind() function.

Merged <- cbind (Subject, Y, X).
Created by merging Subject, Y and X using cbind() function.


8. Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
Tidy <- select (Merged, Subject, Activity, contains ("mean"), contains ("std")). 
10299 rows, 88 columns.
Created by selecting “Merged” columns: Subject, Activity and the measurements on the mean and standard deviation for each measurement.


9. Step 3: Uses descriptive activity names to name the activities in the data set.
Entire numbers in “Activity” column of “Tidy” replaced with corresponding activity taken from second column of the “Activities” variable

10. Step 4: Appropriately labels the data set with descriptive variable names.
All “Acc” in column’s name replaced by “Accelerometer”.
All “Gyro” in column’s name replaced by “Gyroscope”.
All “BodyBody” in column’s name replaced by “Body”.
All “Mag” in column’s name replaced by “Magnitude".
All start with character “t” in column’s name replaced by “Time”.
All start with character “f” in column’s name replaced by “Frequency”.
All “tBody” in column’s name replaced by “TimeBody”.
All “-mean()” in column’s name replaced by “Mean”; “case” is ignored.
All “-std()” in column’s name replaced by “STD”; “case” is ignored.
All “-freq()” in column’s name replaced by “Frequency”; “case” is ignored.
All “angle” in column’s name replaced by “Angle”.
All “gravity” in column’s name replaced by “Gravity”.


11. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

“Final” (180 rows, 88 columns) is created by summarizing “Tidy”, after grouped by “Subject” and “Activity”, taking the means of each variable for each “Activity” and each “Subject”. 
Export “Final” to Final.txt file. 

