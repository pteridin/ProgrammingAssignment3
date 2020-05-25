# Step 0: Import the necessary libraries
if (!require("tidyverse")) {
  require("tidyverse")
}
if (!require("data.table")) {
  require("data.table")
}
if (!require("stringr")) {
  require("stringr")
}


# Step 1: Download the data set if UCI HAR Dataset directory is not already present in your current directory:
if(!dir.exists("UCI HAR Dataset"))
{
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_projectfiles_UCI HAR Dataset.zip")
  unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}


# Step 2: Load and reformat the column label (features) and activity label (label for y_outcome) files
features <- read.delim("UCI HAR Dataset/features.txt", header=F, sep=" ")
activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", header=F, sep=" ")

## Relabel references
names(activity_labels) <- c("id", "activity")
names(features) <- c("Column.N", "Column.Name")

## Reformat features
features$Column.Name <- tolower(features$Column.Name)

## We are only interested in mean and std-deviation
features <- features %>% filter(str_detect(Column.Name, "std") |  str_detect(Column.Name, "mean"))

## Reformat column names
features$Column.Name <- gsub("\\(\\)", "", features$Column.Name)
features$Column.Name <- gsub("-", "_", features$Column.Name)
features$Column.Name <- gsub("\\(", "_", features$Column.Name)
features$Column.Name <- gsub("\\,", "_", features$Column.Name)
features$Column.Name <- gsub("\\)", "", features$Column.Name)

# Step 3: Read data, rename & filter columns
#
# Individual files of test and train dataset will be merged directly by
# row-binding the individual files accordingly. 
# Only std. deviation and mean columns will be 
# kept in the variables (X_test/X_train)

## subject
subject <- fread("UCI HAR Dataset/test/subject_test.txt", header=F) %>% 
            rbind(fread("UCI HAR Dataset/train/subject_train.txt", header=F))

names(subject) <- "subject"

## outcome
y_outcome <- fread("UCI HAR Dataset/test/y_test.txt", header=F) %>% 
                rbind(fread("UCI HAR Dataset/train/y_train.txt", header=F))

names(y_outcome) <- "activity"


## remap activity ID to actual name for readability
y_outcome$activity <- factor(y_outcome$activity, levels=activity_labels$id, labels=activity_labels$activity)


## variables
X_variables <- fread("UCI HAR Dataset/test/X_test.txt", header=F) %>% 
                rbind(fread("UCI HAR Dataset/train/X_train.txt", header=F))

## keep only relevant columns
X_variables <- X_variables %>% select_at(features$Column.N)
names(X_variables) <- features$Column.Name


# Step 4: Merge to one tidy data frames
tidy_mean_stddev_per_measurement <- cbind(subject, y_outcome, X_variables)

# Step 5: Aquire mean data frame for each subject and activity
tidy_mean_per_activity_subject <- tidy_mean_stddev_per_measurement %>% 
                                      group_by(subject, activity) %>% 
                                      summarize_all(mean, na.rm=T)

# Step 6: Write results into CSV files
write.csv(tidy_mean_stddev_per_measurement,"tidy_mean_stddev_per_measurement.csv")
write.csv(tidy_mean_per_activity_subject,"tidy_mean_per_activity_subject.csv")