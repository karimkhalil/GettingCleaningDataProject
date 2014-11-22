# Assume working directory contains the unzipped directory containing data
# We load the various elements of the data
setwd("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

# First, we read the vectors mapping the features and activity labels
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# Next, we load test data
setwd("./test/")
subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

# Next, we load training data
setwd("../train/")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

# Next, we remove unneeded features (keeping only means and sds)
fmeans <- features[grep("mean()",features$V2),1]
fstds <- features[grep("std()",features$V2),1]
fkeep <- c(fmeans,fstds)

test_data <- X_test[,fkeep]
names(test_data) <- c(as.character(features[fmeans,2]),as.character(features[fstds,2]))

train_data <- X_train[,fkeep]
names(train_data) <- c(as.character(features[fmeans,2]),as.character(features[fstds,2]))

# Next, we combine labels (for subjects and activity type)
names(subject_test) <- "subject_ID"
subject_test$subject_ID <- factor(subject_test$subject_ID)
names(y_test) <- "activit_ID"
y_test$activit_ID <- factor(y_test$activit_ID)
levels(y_test$activit_ID) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"
                               ,"SITTING","STANDING","LAYING")
test_data <- data.frame(test_data,subject_test, y_test)

names(subject_train) <- "subject_ID"
subject_train$subject_ID <- factor(subject_train$subject_ID)
names(y_train) <- "activit_ID"
y_train$activit_ID <- factor(y_train$activit_ID)
levels(y_train$activit_ID) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"
                               ,"SITTING","STANDING","LAYING")
train_data <- data.frame(train_data,subject_train, y_train)

# Then, we combine test data and training data
data <- rbind(train_data,test_data)

# Save tidy data into output file
setwd("../")
write.table(data,"Tidy_data.txt")

# Now we create a second data set with the average for each variable, per subject 
# per activity

avgs <- aggregate(data[,1:79],list(subject=data$subject_ID,activity=data$activit_ID),mean)
write.table(avgs,"Tidy_data2_avgs.txt")
