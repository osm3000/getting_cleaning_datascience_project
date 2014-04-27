#Course Project

#Steps for the project
        # Read both the training and the test data sets
        # Read the labels for the data
        # Fix the names of the columns in the datasets, according to the 'features' list
        # Merge data sets
        # Extracts only the measurements on the mean and standard deviation for each measurement.
        # Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Read both the training and the test data sets
dataTraining_0 <- read.table("./train/X_train.txt")
dataTest_0 <- read.table("./test/X_test.txt")

dataTraining <- dataTraining_0
dataTest <- dataTest_0

#Loading labels for both data sets
sub_test_Train <- read.table("./train//subject_train.txt")
sub_test_Test <- read.table("./test/subject_test.txt")
y_test0 <- read.table("./test/y_test.txt")
y_train0 <- read.table("./train/y_train.txt")
y_test <- y_test0
y_train <- y_train0

y_test[y_test == 6] <- "LAYING"
y_test[y_test == 5] <- "STANDING"
y_test[y_test == 4] <- "SITTING"
y_test[y_test == 3] <- "WALKING_DOWNSTAIRS"
y_test[y_test == 2] <- "WALKING_UPSTAIRS"
y_test[y_test == 1] <- "WALKING"

y_train[y_train == 6] <- "LAYING"
y_train[y_train == 5] <- "STANDING"
y_train[y_train == 4] <- "SITTING"
y_train[y_train == 3] <- "WALKING_DOWNSTAIRS"
y_train[y_train == 2] <- "WALKING_UPSTAIRS"
y_train[y_train == 1] <- "WALKING"


# Read the names of variables
dataLabels <- read.table("./features.txt")
features_names <- (dataLabels[,2])
features_names <- as.character(features_names)
features_names <- c("Subject","Activity Code","Activity",features_names)

# Add the labels to the data sets
dataTraining <- cbind(sub_test_Train,y_train0,y_train,dataTraining)
dataTest <- cbind(sub_test_Test,y_test0,y_test,dataTest)

# Fix the names of the columns datasets, according to the 'features' list
names(dataTraining) <- features_names
names(dataTest) <- features_names

# Merge data sets
mergedData <- rbind(dataTraining,dataTest)

# Extracts only the measurements on the mean and standard deviation for each measurement.
toMatch <- c(".*mean\\(\\).*-X$",".*mean\\(\\).*-Y$",".*mean\\(\\).*-Z$", ".*std\\(\\).*-X$",".*std\\(\\).*-Y$",".*std\\(\\).*-Z$")
matches <- unique (grep(paste(toMatch,collapse="|"), features_names, value=TRUE))
mergedData2 <- mergedData[,matches] #Getting only the needed measurements columns

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mergedData3 <- list()
for (subject in 1:30){
        for (activity in 1:6){
                filtered_list <- mergedData[mergedData$"Activity Code" == activity & mergedData$Subject == subject,4:564]
                list_means <- lapply(filtered_list,mean,na.rm=TRUE)
                if (activity == 1){
                        temp <- "WALKING"
                }
                else if (activity == 2){
                        temp <- "WALKING_UPSTAIRS"
                }
                else if (activity == 3){
                        temp <- "WALKING_DOWNSTAIRS"
                }
                else if (activity == 4){
                        temp <- "SITTING"
                }
                else if (activity == 5){
                        temp <- "STANDING"
                }
                else if (activity == 6){
                        temp <- "LAYING"
                }
                list_means <- c("Subject" = subject,"Activity Code" = activity,"Activity" = temp,list_means)
                mergedData3 <- rbind(mergedData3,list_means)
        }
}
row.names(mergedData3) <- NULL
mergedData3 <- as.data.frame(mergedData3)
# temp <- mergedData3$"Activity Code"
# temp[temp == 6] <- "LAYING"
# temp[temp == 5] <- "STANDING"
# temp[temp == 4] <- "SITTING"
# temp[temp == 3] <- "WALKING_DOWNSTAIRS"
# temp[temp == 2] <- "WALKING_UPSTAIRS"
# temp[temp == 1] <- "WALKING"
# mergedData4 <- c(mergedData3[,1],temp,mergedData3[,2:563])
# mergedData4 <- as.data.frame(mergedData4)
