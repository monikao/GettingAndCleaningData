This repository contains the R code to complete the peer assessment for Gettign and Cleaning Data 

Source and full description of original data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

1. Script reads all necesary data from txt files into data frames

2. give columns in X_test and X_trains (training and test sets of data) names provided with features.txt

3. merge data (X_test and X_train) using merge command, by all columns names -> creating X_train_test

4. merge subjects fot tst and train

5. Extract only the measurements on the mean and standard deviation for each measurement. :
	-create feature_md with col names containing only names with mean and std
	-create new data frame (based on X_train_test) containing only columns from feature_md (with means and std)

6. label activities:
	- bind activities from test and train, data frames contains numbers ascribes to actvities
	- create new data frame, which will contain names of activities
	- for formula is getting a number from data frames with numbers, searchs for name of 
		activity ascribed to the number in activity_lab an puts the name in new data frame

7. add data frames with activities names and subjects as first and second column of X_train_test (create X_train_test_mda)

8. create matrix containing means and std for each person for each activity:
	- melt data by subject and activity
	- dcast data

9. write tidy data to txt file