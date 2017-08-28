# Course Project Wearables

* Class:  Coursera: Getting and Cleaning Data
* Name:   Karen S
* Date:   August 28, 2017

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

**Review criteria**

1. The submitted data set is tidy.
1. The Github repo contains the required scripts.
1. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
1. The README that explains the analysis files is clear and understandable.
1. The work submitted for this project is the work of the student who submitted it.

### The Script

The script 'run\_analysis.R' imports the necessary data (features.txt, activity\_labels.txt, and the 3 files in the 'test' and 'train' directories. (Sub-directories 'Inertial Signals' contain raw data and are not used.) It then proceeds to collate, clean and tidy the data. The packages used for this are reshape2, stringr and tidyverse. Here are the steps:

**Step 1**

The 3 files inside each directory 'test' and 'train' are first collated into data frames 'testData' and 'trainData'. These two files are then collated into 'allData'.

**Step 2**

First, the 'features' data frame is indexed to provide only the ones containing the mean and standard deviation values. The index, 'colIndex', is then used to pare down the features table and the columns in the data frame 'allData', creating the new table 'subsetData'.

Feature names are also cleaned up slightly (in table featuresSub) by changing the "t" and "f" at the beginning to "time" and "freq" respectively.

**Step 3**

Activity labels are made more readable by removing the underscore and changing the case to title case, e.g. "WALKING\_UPSTAIRS" becomes "Walking Upstairs". These activity labels replace the activity ids in 'subsetData'.

**Steps 4 and 5**

Because I have chosen to make my data tidy using the long form (using reshape2's `melt()` function), these 2 steps are combined for best efficiency. For an explanation on tiday and my choice of long form please see [my note](AboutTidyData.md "About Long Form Tidy Data").

The steps within this section proceed as follows:

Melt the data to long form, changing the features columns (with generic naming, "X1", "X2", etc) to key and value columns: 'feature\_id' and 'average\_value'.

Summarize the values by subject, activity, and feature.

Now that it's summarized and has less rows, the 'feature\_id' column is cleaned to match the 'feature\_id' column from 'featuresSub' for joining.

Join 'featuresSub' to data and remove unnecessary columns using dplyr's `select()` function.

**Export data**

Create a csv file of the final tidy data frame, named 'tidyWearableLongForm.txt'. This file can be downloaded into working directory and read into R using:

    df <- read.csv("tidyWearableLongForm.txt")
    head(df)

Here is the head of the data, for the curious:

| subject_id | activity | measurement          | average_value         |
|-----------:|----------|----------------------|----------------------:|
| 1          | Walking  | timeBodyAcc-mean()-X | 0.2773307587368421    |
| 1          | Walking  | timeBodyAcc-mean()-Y | -0.017383818527368422 |
| 1          | Walking  | timeBodyAcc-mean()-Z | -0.11114810354736843  |
| 1          | Walking  | timeBodyAcc-std()-X  | -0.28374025884210524  |
| 1          | Walking  | timeBodyAcc-std()-Y  | 0.11446133674736843   |
| 1          | Walking  | timeBodyAcc-std()-Z  | -0.2600279022105263   |

---
##### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

For more info: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
