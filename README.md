# human_activity_recognition
read, clean and summarize the UCI human activity recognition dataset.

## Data Collecting
Download the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
unzip the contents to a 'data' folder in the working directory.

## Running the run_analysis.R file

**NOTE:** make sure the zip contents are unzipped into 'data' folder.
The R file does the following
  * read the data
  * combine all variables into train and test data set.
  * merge the train and test into a single data set.
  * Subsets only the mean() and std() containing features along with the activity and subject variables.
  * summarises the average(mean) for all the features for each subject and each activity.
  * writes the tidy data containg the averages into a text file into the working Directory. 
