# Getting-and-Cleaning-Data-Project-
Repository for hosting Getting and Cleaning Data Course Project

This github repository contains a script for generating the tidy dataset from the Samsung data and a codebook describing the variables in the tidy dataset.

The repo includes the following files:
=========================================

- 'run_analysis.R' will run as long as the Samsung data is your working directory. E.g. setwd("~/coursera/GettingCleaningData/Assignment/UCI HAR Dataset"). The output will be a dataframe called "tidy_data" that will match the contents of the "tidy.txt" file. The script meets the project requirements with the following steps: 1) Load the raw data for train & test set, activity labels, feature labels; 2) Give features descriptive variable names; activities described w/ labeled levels; 3) bind feature columns with subject and activity info; 4) Extract mean and standard deviation features, combine train and test sets, check for NAs; 5) create 2nd, independent tidy dataset summarizing column means grouped by id and activity.

- 'codebook.md' describes the variables in the tidy dataset, which include the fixed variables "id" and "activity" and 66 measured feature variables. 

Each record in the tidy dataset has the following:
======================================
- Mean normalized values for 66 feature variables. 
- An activity label. 
- An identifier of the subject who carried out the experiment.

Open the tidy dataset file named "tidy.txt" with read.table("./tidy.txt", header=TRUE).


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature value is a mean

With guidance from the following blog post: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
