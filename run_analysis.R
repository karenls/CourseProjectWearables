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
library(tidyverse)
library(stringr)

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

#  'test' set
#  'train' set
#  'test' + train'

testData <- bind_cols(subjectTest, testAct, testSet)
trainData <- bind_cols(subjectTrain, trainAct, trainSet)
allData <- bind_rows(testData, trainData)

#  Delete 'test' & 'train' sub-tables to clean up environment

rm(list = c("subjectTest", "testAct", "testSet",
     "subjectTrain", "trainAct", "trainSet"))

## STEP 2
## FIND SUBSET OF FEATURES THAT ARE MEAN AND STD ONLY

#  First get index of desired features
#  Add 2 to each element to skip subject and activity columns for subsetting
#  Create intermediate tibble with `mean` & `std` feature columns

colIndex <- as.integer(grep("-mean\\(|-std\\(",
                            features$feature,
                            ignore.case=TRUE))
colIndex <- (colIndex + 2L)

subsetData <- allData %>%
    select(subject_id, activity_id, colIndex)

## STEP 3

## MAKE ACTIVITY NAMES READ NICER & APPLY TO DATASET

#  Change underscore to space
#  Change case from all caps to title-style
#  Make activity a factor with level order same as original table
#  Use join, then select to change 'activity_id' to 'activity'
#  Arrange by subject & activity

activities$activity <- sub("_", " ", activities$activity)
activities$activity <- str_to_title(activities$activity)
activities$activity <- factor(activities$activity,
                              levels = activities$activity)

subsetData <- inner_join(subsetData, activities,
                               by = "activity_id")
subsetData <- select(subsetData, subject_id, activity, starts_with("X")) %>%
    arrange(subject_id, activity)


## STEPS 4 AND 5
## Note: these steps are being being combined out of order due to changing
##    the data to long form (see readme for explanation).

## (Step 5A) Melt data to long form calculating means
##    for each combo of subject & activity
subsetMelted <- as_tibble(melt(subsetData,
                                   id.vars = c("subject_id", "activity"),
                                   variable.name = "old_cols",
                                   value.name = "average_value"))

## (Step 4a) Add column to features containing old column names to join by
features <- add_column(features, old_cols = colnames(allData[3:563]))

tidySubsetData <- subsetMelted %>%
                    group_by(subject_id, activity, old_cols) %>%
                    summarize(average_value = mean(average_value))

#  Change 'old_cols' to character type for table join
#  - Not necessary but causes a warning otherwise
tidySubsetData$old_cols <- as.character(tidySubsetData$old_cols)


## (Step 4b) Replace feature ids with feature names (created Step 2)

#  Join tidydata with features on 'feature'; remove unneeded via 'select'
#  - Note: join keeps ordering of group_by; merge does not!
tidySubsetData <- inner_join(tidySubsetData, features,
                          by = "old_cols")

tidyWearableLongForm <- tidySubsetData %>%
                    select(subject_id, activity, feature, average_value)


## FINALLY, OUTPUT TIDY DATA TO A CSV-DELIMITED FILE

write_csv(tidyWearableLongForm, "./tidyWearableLongForm.csv")

## TEST PRINT TO CONSOLE
# head(read_csv("./tidyWearableLongForm.csv"))