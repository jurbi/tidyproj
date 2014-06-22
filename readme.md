## Introduction

The purpose of this project is to demonstrate the process of collecting, working with, and cleaning a data set. The goal is to prepare tidy data that can be used for later analysis. 

The data that will be used is the Human Activity Recognition Using Smartphones Datatset that comes from the UCI Machine Learning Repository. It represents data built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

## Description

This project contains one R script called <b>run_analysis.R</b> that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
## Output
The output from the R Script is a dataset called tidy.txt and will be created in the current working directory. This file is tab delimited and includes a header line that contains column names. A codebook that describes the fields is included as part of this repository.

## Notes
<ol>
<li>Created on Windows 8 computer running R Version 3.1.0 64-bit. Programs has not been tested in other environments</li>
<li>The script downloads the required data to the current working directory and upzips it into a temp directory. From there, it performs all the tasks listed above. It does not check if the data already exists in the working directory</li>
<li>The assignment was vague regarding the extraction of variables from the original datasets. The request specified only the mean and standard deviation measurements should be chosen; however, there is some question whether that should include "meanFreq" and "gravityMean" measurements. Because we don't have a questions to answer from this analysis and we're concentrating on the data cleaning steps, they are left out of the dataset created by this script. The regex expression to include them if desired can be found in the program comments.</li>
<li>Consideration was given to creating a long vs. wide dataset. Again, since there is no specific question to be answered, the output was kept wide since certain analyses uses data in this format. The reshape2 library can be easily been used to "melt" the data into a long format</li>
</ol>
