## Getting and Cleaning Data | Course Project
## Karen Saul                      2017-08-23

# The purpose of this project is to demonstrate your ability to collect, work
# with, and clean a data set. The goal is to prepare tidy data that can be used
# for later analysis.

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.


## LOAD LIBRARIES OFFERING FASTER & BETTER FUNCTIONS
library(reshape2)
library(stringr)
library(tidyverse)

## READ IN FILES AS TBL_DFs (TIBBLEs)
#  'X_test.txt' and 'X_train.txt' are fwf with variable white space
#  so I'm using read_table2 for those

subjectTest <- read_delim("./data/test/subject_test.txt",
                           delim = " ",
                           col_names = c("subject_id"))

testSet <- read_table2("./data/test/X_test.txt",
                       col_names = FALSE)

testAct <- read_delim("./data/test/y_test.txt",
                        delim = " ",
                       col_names = c("activity_id"))

subjectTrain <- read_delim("./data/train/subject_train.txt",
                           delim = " ",
                           col_names = c("subject_id"))

trainSet <- read_table2("./data/train/X_train.txt",
                        col_names = FALSE)

trainAct <- read_delim("./data/train/y_train.txt",
                       delim = " ",
                       col_names = c("activity_id"))

activities <- read_delim("./data/activity_labels.txt",
                         delim=" ",
                         col_names = c("activity_id", "activity"))

features <- read_delim("./data/features.txt",
                       delim = " ",
                       col_names = c("feature_id", "feature"))

## STEP 1
## COMBINE DATA

#  test set, train set, test + train

testData <- bind_cols(subjectTest, testAct, testSet)
trainData <- bind_cols(subjectTrain, trainAct, trainSet)
allData <- bind_rows(testData, trainData)

#  Delete 'test' & 'train' sub-tables to clean up environment

rm(list = c("subjectTest", "testAct", "testSet",
            "subjectTrain", "trainAct", "trainSet"))

## STEP 2
## FIND SUBSET OF FEATURES THAT ARE MEAN AND STD ONLY

#  First get index of desired features
#  Edit desired features to read better based on colIndex
#  For subsetting, add 2 to each element to skip subject and activity columns
#  Create intermediate tibble with `mean` & `std` feature columns

colIndex <- grep("(-mean|-std)\\(", features$feature, ignore.case=TRUE)

featuresSub <- features[colIndex,]
featuresSub$feature <- sub("^(t)", "time", featuresSub$feature)
featuresSub$feature <- sub("^(f)", "freq", featuresSub$feature)

colIndex <- colIndex + 2L
subsetData <- allData %>%
    select(subject_id, activity_id, colIndex)


## STEP 3
## MAKE ACTIVITY NAMES READ NICER & APPLY TO DATASET

#  Change underscore to space
#  Change case from all caps to title-style
#  Make activity a factor with level order same as original table

activities$activity <- sub("_", " ", activities$activity)
activities$activity <- str_to_title(activities$activity)
activities$activity <- factor(activities$activity,
                              levels = activities$activity)

#  Use join to add activity names to data
#  Use select to drop 'activity_id' & arrange by subject & activity

subsetData <- inner_join(subsetData, activities, by = "activity_id")
subsetData <- select(subsetData, subject_id, activity, starts_with("X")) %>%
              arrange(subject_id, activity)


## STEPS 4 AND 5
## Note: these steps are being being combined due to changing
##    the data to long form (see 'AboutTidyData.md' for explanation).

#  Melt data to long form
#  Find the means of each feature for each subject & activity
#  Edit 'feature_id' values & change to int for later join
#  Join data with featuresSub on 'feature_id' & remove unneeded columns via 'select'
#     - Note: join keeps ordering of group_by; merge does not!

subsetMelted <- as_tibble(melt(subsetData,
                               id.vars = c("subject_id", "activity"),
                               variable.name = "feature_id",
                               value.name = "average_value"))

tidySubsetMelted <- subsetMelted %>%
    group_by(subject_id, activity, feature_id) %>%
    summarize(average_value = mean(average_value))


tidySubsetMelted$feature_id <- as.integer(sub("[[:alpha:]]", "",
                                              tidySubsetMelted$feature_id,
                                              fixed = FALSE))

tidySubsetMelted <- inner_join(tidySubsetMelted, featuresSub, by = "feature_id")

#  Final cleanup of desired columns

tidyWearableLongForm <- tidySubsetMelted %>%
                        select(subject_id, activity,
                               measurement=feature, average_value)


## FINALLY, OUTPUT TIDY DATA TO A CSV-DELIMITED FILE

write.table(tidyWearableLongForm, "./tidyWearableLongForm.txt", row.name=FALSE)

## TEST PRINT TO CONSOLE
# head(read.table("./tidyWearableLongForm.txt", header = TRUE))