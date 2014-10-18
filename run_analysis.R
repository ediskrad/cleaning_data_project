 
# Downloads the file to the current working directory if it does not exist
zipfile = "Dataset.zip"
if ( ! file.exists(zipfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipfile, method="curl", quiet = TRUE)
  print("Downloaded file to working directory")
}


# Loading all the desired files into data.frames
for (set in c("train","test")) {
  for (pre in c("X_","y_")) {
    filename = paste("UCI HAR Dataset/", set, "/", pre, set, ".txt", sep="")
    name = paste(pre, set, sep="")
    assign(name, read.table(unz(zipfile, filename)))
  }
}


# Merging of the training data/labels (we delete unused objects to free memory)
training_set = data.frame(y_train, X_train)
rm(y_train, X_train)


# Merging of the test data/labels (we delete unused objects to free memory)
test_set = data.frame(y_test, X_test)
rm(y_test, X_test)


# Merging of test set and training set
data_set = rbind(test_set, training_set)
rm(test_set, training_set)


