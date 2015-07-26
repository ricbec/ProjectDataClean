library(dplyr)
library(reshape2)
## READ THE COMMON DATA
activity.labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
## READ THE TEST DATA
subject.test <- read.table("test/subject_test.txt")
y.test <- read.table("test/y_test.txt")
x.test <- read.table("test/X_test.txt")
## MERGE THE ACTIVITY LABELS
y2.test <- merge(y.test, activity.labels, by.x = "V1", by.y = "V1" )
## COMBINE THE TEST DATA
combined.test <- cbind(subject.test, y2.test, x.test)
## SET COLUMN NAMES
colnames(combined.test) <- c("subject.id", "activity.id", "activity.name", as.vector(features[, 2]))
## READ THE TRAIN DATA
subject.train <- read.table("train/subject_train.txt")
y.train <- read.table("train/y_train.txt")
x.train <- read.table("train/X_train.txt")
## MERGE THE ACTIVITY LABELS
y2.train <- merge(y.train, activity.labels, by.x = "V1", by.y = "V1" )
## COMBINE THE TRAIN DATA
combined.train <- cbind(subject.train, y2.train, x.train)
## SET COLUMN NAMES
colnames(combined.train) <- c("subject.id", "activity.id", "activity.name", as.vector(features[, 2]))
## COMBINE THE TEST AND TRAIN DATA
combined.data <- rbind(combined.test, combined.train)
## GETTING THE NAMES
data.names <- names(combined.data)
## SUBSETTING NAMES WITH MEAN AND STD .
data.names2 <- grepl ("mean|std", data.names)
## SELECTING MEAN AND STD DATA
selected.data <- combined.data[, data.names2 ]
## ADDING IDS TO EXTRACTED DATA
selected.data <- cbind(combined.data[, 1:3], selected.data)
##REMOVING ACTIVITY ID
s2 <- select(selected.data, -activity.id)
## MELT VARIABLE DATA
data.melt <- melt(s2, id = c("subject.id", "activity.name"), meassure.vars=c(4:78))
## ORDERING
odata <- arrange(data.melt, subject.id)
##GROUPING DATA
gdata <- group_by(odata, subject.id, activity.name, variable, add = TRUE)
##SUMMARIZING DATA
sum <- summarise(gdata, mean(value))
##OUTPUT THE DATA
write.table(sum, file = "tidy_data.txt", row.names = FALSE)
