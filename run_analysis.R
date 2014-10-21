# INSTRUCTIONS
#
# Create one R script called run_analysis.R that does the following.
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set.
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# Setting library dependences
if (!require("reshape2")) {
  install.packages("reshape2")
}
require("reshape2")

# Downloads the file to the current working directory if it does not exist
zipfile = "Dataset.zip"
if ( ! file.exists(zipfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipfile, quiet = TRUE)
  print("Downloaded file to working directory")
}


# Loading all the desired files into data.frames
for (set in c("train","test")) {
  for (pre in c("X_","y_","subject_")) {
    filename = paste("UCI HAR Dataset/", set, "/", pre, set, ".txt", sep="")
    name = paste(pre, set, sep="")
    assign(name, read.table(unz(zipfile, filename)))
  }
}


# Merging of the training data/labels (we delete unused objects to free memory)
training_set = data.frame(y_train, subject_train, X_train)
rm(y_train, X_train, subject_train)


# Merging of the test data/labels (we delete unused objects to free memory)
test_set = data.frame(y_test, subject_test, X_test)
rm(y_test, X_test, subject_test)


# Merging of test set and training set
data_set = rbind(test_set, training_set)
rm(test_set, training_set)

# Loading of features.txt file
filename = "UCI HAR Dataset/features.txt"
features = read.table(unz(zipfile, filename))
selected_features = features[grepl("mean|std",features$V2),]

# data_set variable reduction. As we have added a first column with the activity, we have to add 1 to the positions
# of the features
data_set_red = data_set[, c(1, 2, selected_features[[1]] + 2)]
rm(data_set)

# Renaming column names in data_set_red
names(data_set_red) = c("Activity","Subject", as.character(selected_features$V2))

# Renaming and factorizing the Activity column
filename = "UCI HAR Dataset/activity_labels.txt"
activities = read.table(unz(zipfile, filename))
data_set_red$Activity = activities[data_set_red$Activity, 2]

# Summarizing by activity/subject and writing to a txt file
id_labels =  names(data_set_red)[1:2]
data_labels = names(data_set_red)[3:dim(data_set_red)[2]]
melt_data = melt(data_set_red, id = id_labels, measure.vars = data_labels)

tidy_data   = dcast(melt_data, Subject + Activity ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
