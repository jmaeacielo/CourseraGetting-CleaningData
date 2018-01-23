Getting and Cleaning Data

This repository contains files for the final assignment for Coursera's Getting and Cleaning Data module. Specifically, it makes use of the Human Activity Recognition Using Smartphones Dataset (Reyes-Ortiz et. al., 2012) to illustrate skills learned throughout the four-weeks of the module. 

Required packages to be installed are dplyr and reshape2. 

The R script, run_analysis.R, is intended to do the following:
    1. Download the dataset if it does not already exist in the working directory;
    2. Reads the training and test datasets;
    3. Loads and consolidates the activity labels, subjects, and features; 
    4. Merges and appends the two datasets into one;
    5. Filters and keeps columns which reflect either a mean or a standard deviation;
    6. Renames the activity descriptions and column names in order to be clearer and readable to any user;
    7. Conversion of the activity and subject columns into factors; and
    8. Creation of a tidy dataset that contains the mean of each variable for each subject-activity. 
    
The tidy.txt file illustrates an output of the run_analysis.R script. 

Lastly, the codebook.rmd file is intended to provide a guide for people to understand how the dataset was created, the original study design, and the experimental study design. 


REFERENCE:

Reyes-Ortiz, J., Anguita, D., Ghuio, A., Oneto, L., & Parra, X. (2012). UCI Machine Learning Repository: Center for Machine Learning and Intelligent Systems. Retrieved from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
