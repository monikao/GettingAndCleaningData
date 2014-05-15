## readt data from txt files
subject_test <- read.table(".\\test\\subject_test.txt")
X_test <- read.table(".\\test\\X_test.txt")
y_test <- read.table(".\\test\\y_test.txt")

subject_train <- read.table(".\\train\\subject_train.txt")
X_train <- read.table(".\\train\\X_train.txt")
y_train <- read.table(".\\train\\y_train.txt")

activity_lab <- read.table(".\\activity_labels.txt")
features <- read.table(".\\features.txt")


##give columns names
colnames(X_test) <- features$V2
colnames(X_train) <- features$V2
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"
colnames(y_test) <- "activity"
colnames(y_train) <- "activity"


##merging X_train and X_test
X_train_test <- merge(X_test, X_train, all=TRUE)
subjects <- rbind(subject_test, subject_train)


##Extracts only the measurements on the mean and standard deviation for each measurement. 
features_md <- grepl("mean()", features$V2) | grepl("std()", features$V2)
features_md <- features$V2[features_md]
X_train_test_md <- X_train_test[, features_md]

##label activities
activities <- rbind(y_test, y_train)
activities_names = data.frame(1:nrow(activities))
for(i in 1:nrow(activities)){
  act_num <- activities$activity[i]
  activities_names[i,1] = as.character(activity_lab$V2[act_num])
}


##add labeled activities to X_train_test_md 
X_train_test_mda <- cbind(activities_names, subjects, X_train_test_md)
colnames(X_train_test_mda)[1] <- "activity"

##create new matrix
 ## order data subjects, activities
X_train_test_mda <- X_train_test_mda[order(X_train_test_mda$subject, X_train_test_mda$activity),]

 ##melt data
melt_XTTmda <- melt(X_train_test_mda, id=c("subject","activity"))

 ## cast
tidyData <- dcast(melt_XTTmda, subject + activity ~ ..., mean)


## writing table to text file
write.table(tidyData, file="./run_analysis.txt", sep="\t", row.names=FALSE)