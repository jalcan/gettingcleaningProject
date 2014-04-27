
#####
# 1 Merges the training and the test sets to create one data set.
#####

dataTrain <- read.table("train//X_train.txt")
dataTest <- read.table("test//X_test.txt")

# dataset "data" will be the  result of appending X_test.txt to X_train.txt
data <- rbind(dataTrain,dataTest)

# free memory (no more need of variables dataTrain and dataTest)
rm(dataTrain,dataTest)

# same process for subjects and labels
subjectTrain <- read.table("train//subject_train.txt")
subjectTest <- read.table("test//subject_test.txt")
subject <- rbind(subjectTrain,subjectTest)
rm(subjectTrain,subjectTest)

names(subject) <- "Subject"

activityTrain <- read.table("train//y_train.txt")
activityTest <- read.table("test//y_test.txt")
activity <- rbind(activityTrain,activityTest)
rm(activityTrain,activityTest)

names(activity) <- "Activity"

#####
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#####

feats <- read.table("features.txt")

# getting the indexes of every feature text with "-mean()" or "-std()" in it
mean_std_idxs <- grep("-mean\\(\\)|-std\\(\\)", feats[,2])

# subsetting the dataset by keeping only the indexes of the mean and std
data <- data[, mean_std_idxs]

# associating feature names to the dataset
names(data) <- feats[mean_std_idxs,2]
names(data) <- make.names(names(data))

# as make.names will make a string like "tBodyAcc-mean()-Y" become "tBodyAcc.mean...Y" 
# I decided to keep only one point before the final Axis:  tBodyAcc.mean.Y"
names(data) <- gsub("\\.\\.", "", make.names(names(data2)))

#####
# 3 Uses descriptive activity names to name the activities in the data set
#####

actLabel <- read.table("activity_labels.txt")

# getting the activity IDs in the dataset 
idIndataset <- actvity[,1]

# changing the activity IDs for its description (2nd col) in the actLabel
activity[,1] <- actLabel[idIndataset,2]


#####
# 4 Appropriately labels the data set with descriptive activity names. 
#####

descripData <- cbind(subject, activity, data)
names(descripData)
sort(subject[,1])
head(descripData[,1:10])

#####
# 5 Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject. 
#####

# There will be a row in the resulting dataset for every diferent subject and activity (subject x activity)
# there will be as many columns in the resulting dataset as in the merged descriptive data set

individuals <- unique(subject)

numrow = nrow(individuals)*nrow(actLabel)
numcol = ncol(descripData)
avgDataSet <- as.data.frame(matrix(nrow=numrow, ncol= numcol ))
names(avgDataSet) = names(descripData)

idx <- 1
for (indiv in individuals[[1]]){
        
        for(act in actLabel[[2]]){
        
                avgDataSet[idx, 1] <- indiv
                avgDataSet[idx, 2] <- act
                # getting the subset for a given individual/subject and a given activity. 
                indivActSubset <- subset(descripData, Subject==indiv & Activity==act)
                # computing the means of every column in the subset 
                avgDataSet[idx, 3:numcol] <- colMeans(indivActSubset[,3:numcol])
                idx <- idx+1
        }
}


write.table(avgDataSet, "avgDataSet.txt", row.names=FALSE)








