# Getting and Cleaning Data Oct 6th - Nov 3rd


## Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. Details of the data sources are described in the ```CodeBook.md``` file.


## Steps

As asked in the project instructions, 5 main steps have been followed by the ```run_analysis.R``` script:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set.
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These 5 steps are performed by the script ```run_analysis.R``` contained in this repo. You can check some details in the next part.
  

## Notes about ```run_analysis.R```:

* Requires ```reshape2```. If it is not installed it will be downloaded

* Downloads the ZIP file with all the data to the set working directory

* Loads the desired files directly from the ZIP file. Probably not the most efficient, but it's a way of learning about `unz` funcion

* Will create a file called ```tidy_data.txt``` in the working directory