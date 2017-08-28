## Data Dictionary -- tidyWearableLongForm.txt

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

### The Experiments

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. See [features\_info.md](features\_info.md) for more details.

### The Data

The data used for this project comes from UC Irvine's Machine Learning Labratory called "Human Activity Recognition Using Smartphones Dataset
Version 1.0". A full description is available at the site where the data was obtained:

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data for the project:

[UCI HAR Data (zip)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The zip is downloaded and extracted into the working directory. The directory was renamed from 'UCI HAR Dataset' to 'data', however, file names inside were not changed.

### Data Tidying

Tidying of the data is done in the R programming language. File is [run\_analysis.R](run\_analysis.R "R script")

Eight data files are imported and combined, subsetted and tidied using Hadley Wickham's definition of [tidy data](AboutTidyData.md  "About Long Form Tidy Data").

### Tidied Data Description

* File name: [tidyWearableLongForm.txt](tidyWearableLongForm.txt "The exported tidy data")
* Dimensions: 11880 rows x 4 columns

Summary: The data contains each feature/measurement that had already been processed to get the mean and standard deviations applied to them, as well as other noise-redection algorithms (see [features\_info.md](features\_info.md)) These were then summarized by finding the mean of those values by subject, activity and feature/measurement.

**Column Variables:**

<dt>subject_id</dt>
<dd>The ID of the subject participating in all six activities. 9 were in the test set and 21 were in the train set.

Class: integer

Values: 1-30
</dd>

<dt>activity</dt>
<dd>The names of each of six activities.

Class: factor

Values: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying</dd>

<dt>measurement</dt>
<dd>The 66 features (for each subject and activity) which had been pre-processed with mean or standard deviation.

Class: character

Values:</dd>

    timeBodyAcc-mean()-X            timeBodyAcc-mean()-Y          
    timeBodyAcc-mean()-Z            timeBodyAcc-std()-X           
    timeBodyAcc-std()-Y             timeBodyAcc-std()-Z           
    timeGravityAcc-mean()-X         timeGravityAcc-mean()-Y       
    timeGravityAcc-mean()-Z         timeGravityAcc-std()-X        
    timeGravityAcc-std()-Y          timeGravityAcc-std()-Z        
    timeBodyAccJerk-mean()-X        timeBodyAccJerk-mean()-Y      
    timeBodyAccJerk-mean()-Z        timeBodyAccJerk-std()-X       
    timeBodyAccJerk-std()-Y         timeBodyAccJerk-std()-Z       
    timeBodyGyro-mean()-X           timeBodyGyro-mean()-Y         
    timeBodyGyro-mean()-Z           timeBodyGyro-std()-X          
    timeBodyGyro-std()-Y            timeBodyGyro-std()-Z          
    timeBodyGyroJerk-mean()-X       timeBodyGyroJerk-mean()-Y     
    timeBodyGyroJerk-mean()-Z       timeBodyGyroJerk-std()-X      
    timeBodyGyroJerk-std()-Y        timeBodyGyroJerk-std()-Z      
    timeBodyAccMag-mean()           timeBodyAccMag-std()          
    timeGravityAccMag-mean()        timeGravityAccMag-std()       
    timeBodyAccJerkMag-mean()       timeBodyAccJerkMag-std()      
    timeBodyGyroMag-mean()          timeBodyGyroMag-std()         
    timeBodyGyroJerkMag-mean()      timeBodyGyroJerkMag-std()     
    freqBodyAcc-mean()-X            freqBodyAcc-mean()-Y          
    freqBodyAcc-mean()-Z            freqBodyAcc-std()-X           
    freqBodyAcc-std()-Y             freqBodyAcc-std()-Z           
    freqBodyAccJerk-mean()-X        freqBodyAccJerk-mean()-Y      
    freqBodyAccJerk-mean()-Z        freqBodyAccJerk-std()-X       
    freqBodyAccJerk-std()-Y         freqBodyAccJerk-std()-Z       
    freqBodyGyro-mean()-X           freqBodyGyro-mean()-Y         
    freqBodyGyro-mean()-Z           freqBodyGyro-std()-X          
    freqBodyGyro-std()-Y            freqBodyGyro-std()-Z          
    freqBodyAccMag-mean()           freqBodyAccMag-std()          
    freqBodyBodyAccJerkMag-mean()   freqBodyBodyAccJerkMag-std()  
    freqBodyBodyGyroMag-mean()      freqBodyBodyGyroMag-std()     
    freqBodyBodyGyroJerkMag-mean()  freqBodyBodyGyroJerkMag-std()

<dt>average_value</dt>

<dd>The mean for the measurement in its row.

Class: numeric

Values: varies; min being -0.99767 and max being 0.97451</dd>

---
##### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
