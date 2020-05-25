# Getting and Cleaning Data Course Project

## Goal

The goal of this project of the Coursera Course `Getting and Cleaning Data` week 4 is to prepare and clean up data from 

This should be done with an R script called ```run_analysis.R``` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to recreate the tidy data set

1. Clone this repository with ```git clone https://github.com/pteridin/ProgrammingAssignment3```   
2. Run ```run_analysis.R``` in your R environment
3. The following files will be created:   

## Output

### tidy_mean_stddev_per_measurement.txt
Extracted mean and standard deviation for each measurement.

### tidy_mean_per_activity_subject.txt
Extracted mean of each variable for each activity and each subject.

## Dependencies
```run_analysis.R``` file will install the dependencies automatically. It depends on ```tidyverse```, ```stringr``` and ```data.table```. 

## License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1]    

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012   
  
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.   

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.   