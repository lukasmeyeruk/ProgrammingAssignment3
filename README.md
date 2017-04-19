# Code Book Programming Assignment

This document describes the code within the script 'run_analysis.R'.

## Loading the data
The script loads all the Samsung data in your working directory and creates individual data frames containing the source data.

The following data is loaded:
* Label Names of activites: (activity_labels.txt)
* Column Names of features: (features.txt)
* Training Data for X: (train/X_train.txt)
* Test Data for X: (test/X_test.txt)
* Training Data for y: (train/y_train.txt)
* Test Data for y: (test/y_test.txt)
* Subject Data: ([test|train]/subject_train.txt)
* Body Acceleration Data (/[train|test]/Inertial Signals/body_acc_[x|y|z]_[train|test].txt)

## Manipulating the data

1. Combining test and training data set for X
1. Define Column Names for X based on features read from features.txt
1. Combining test and training data set for y 
1. Match and Lookup activity names and replace activity number in y data set with proper name as well as assigning a proper column name
1. Combine training and test data sets for body acceleration, gyro and total acceleration readings on x, y, z
1. Beautify Labels by remove V and adding proper description for body acc, gyro and total acceleration readings
1. Combine training and test data set for subject and assign proper column name
1. Combine all different data sets into one large data frame for analysis.
1. Extract only the measurements related to mean and stddev
1. Aggregate average on each activity & each subject into a second tidy data set

## Output and extracted data
The Script creates two data frames that contain the following information:
1. data_mean_std: Table containing all information limited to columns providing information on mean and stddev
1. data_2_mean_by_subject_label: Table with aggregated information by subject and label showing the mean of all measurements.

The script writes the table 'data_2_mean_by_subject_label' into a txt file without printing the header information.
