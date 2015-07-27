# ProjectDataClean Code Book
# 
Project for Coursera Getting ad Cleaning Data

The goal for this project is to produce a tidy dataset showing the analysis of the mean for the variables grouped into subjects and activities of the subjects.

The initial data was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Several modifications were made to be able to summarize the data.

The first think to do was read the data in R. For that the function read.table was used as suggested in the thread by David Hood

https://class.coursera.org/getdata-030/forum/thread?thread_id=37

I used to libraries dplyr and rechape2, to be able to use the functions, merge, melt, select, and arrange. 

Started with the test group.

After reading the data combined the data of the subjects, the type of activity, and the data frame with the meassures into one data frame called combined.test

Then I set the column names from the features.txt adding the column names for the binded data as subject.id, activity.id and activity.name

The same procedure was applied to the train group

Finally both groups were binded y columns to form a big data set.

The seccond goal ws to extract the mean and standart deviation. For this task I used the names vector, and a regexp in the grepl function to accurately match 79 column names with the words mean or std. Then a subset for the true columns were stored in the selected.data variable. A seccond data frame was created to remove the activity.id column and called s2.

To be able to apply the summarize function I melt all the variable columns into the data.melt. It was ordered and grouped and finaly summarized into the sum variable. This was output to tidy_data.txt file using the write.table function.

The variables in the tidy_data.txt are

subject.id
    1-30 id for each subject 

activity.name
    Names for the six activities

variable
    Each of the mean and sdt features extracted from the data set

mean(value)
    The mean for each group of feature for each activity for each subject


