The script file run_analysis.R depends on dplyr package. 
If you do not have dplyr installed, the script will install dplyr package for you.

Run_analysis.R script merges the training and the test sets to create one data set, 
as well as the subject id and activity id.
Then, it extracts only the measurements on the mean and standard deviation for each measurement. 
Next, it uses descriptive activity names, stored in activity_labels.txt, to name the activities in the data set and 
appropriately labels the data set with descriptive variable names.
After that, it creates a second, independent tidy data set, tidyds, with the average of each variable for each activity and each subject.
In the end, it output tidyds into the file -- tidyds.txt.
