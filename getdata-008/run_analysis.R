
if("dplyr" %in% rownames(installed.packages()) == FALSE) 
{
    install.packages("dplyr")
}
library(dplyr)

## step1: Merges the training and the test sets to create one data set.
X_test <- read.table("test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
X_train <- read.table("train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
X_total <- rbind(X_test, X_train)

## step1: Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt",stringsAsFactors=FALSE)
mean_col_inx <- grep("mean()", features$V2, fixed=TRUE)
std_col_inx <- grep("std()", features$V2, fixed=TRUE)
col_inx <- sort(c(mean_col_inx, std_col_inx))
X_part <- X_total[,col_inx]
# add label names
names(X_part) <- features[col_inx, 2]

# add subject id
sbj_test <- read.table("test/subject_test.txt", header=FALSE, stringsAsFactors = FALSE)
sbj_train <- read.table("train/subject_train.txt", header=FALSE, stringsAsFactors = FALSE)
X_part <- mutate(X_part, subject=c(sbj_test[[1]], sbj_train[[1]]))

# add activity
y_test <- read.table("test/y_test.txt", header=FALSE, stringsAsFactors = FALSE)
y_train <- read.table("train/y_train.txt", header=FALSE, stringsAsFactors = FALSE)
X_part <- mutate(X_part, activity_id=c(y_test[[1]], y_train[[1]]))

## step3: Uses descriptive activity names to name the activities in the data set
act_labels <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors = FALSE)
names(act_labels) <- c("id","activity")
X_part <- merge(X_part,act_labels,by.x="activity_id",by.y="id")
X_part$activity_id <- NULL

## step4: Appropriately labels the data set with descriptive variable names.
labels <- names(X_part)
names(X_part) <- gsub("-|\\(|\\)", "", labels)

## step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
by_act_sbj <- group_by(X_part, activity, subject)
tidyds <- summarise_each(by_act_sbj, funs(mean)

write.table(tidyds, file="tidy-data.txt", row.names = FALSE)
                         