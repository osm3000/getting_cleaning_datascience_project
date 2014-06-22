# README for the peer Assignment

## Steps for the R scipt

### Read both the training and the test data sets
### Read the labels for the data
### Read the features list --> the names of the columns in the dataset
### Set the names of the columns in the datasets, according to the 'features' list
### Merge data sets
### Extracts only the measurements on the mean and standard deviation for each measurement.
### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
### Print the output

I'll also explain my understanding for the different parts of the assignment.

## The task required in the project according to the project desciption
According to the course description
### You should create one R script called run_analysis.R that does the following. 

### 1. Merges the training and the test sets to create one data set.
##### This is straight forward. I use "rbind" to combine both the test and the training data sets together. The dataset that has such functionality is called "mergedData"

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##### I've made a lot of search about the exact meaning of this point. What I feel is right is to make a specific data set, containing only the columns from the original merged datasets which has the following words "mean-()" and "std-()". The data set containing these information is named "mergedData2".

### 3. Uses descriptive activity names to name the activities in the data set
##### See the 4th point also, since they both - I believe - has the same meaning


### 4. Appropriately labels the data set with descriptive activity names. 
##### For this issue, I combined 3 columns to the merged data set. The first is the "subject", parsed from the given subject file for each data set. The 2nd is the "Activity Code", which has the code for the acitiviy, parsed from the 'y' file for each dataset. The 3rd is the mapping between the "Activity Code" and the actual activity name, called "Activity". This is being done by simple comparisons and replacements, like " y_train[y_train == 6] <- "LAYING" ". I'm sure there's more effecient way. Combining these columns together with the merged dataset gives us a very nice and understood labelled dataset.



### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##### I've also made a deep search about this issue, however, I didn't have a clear meaning for it. Based on my understanding, for all the 561 features given in the original datasets, I took the 'mean' for each of them, corresponding to each activity for each subject. So, we've 30 subjects, and for each of them we've 6 activities, we've 180 rows and 561 column - each column is the mean of that feature with respect to the activity of each subject -. Again, note this is only based on my understanding for the problem. I added extra 3 columns, "Subject","Activity Code" and "Activity" to make the data more readable. The output of this step is "mergedData3"

### To print the tidy data into a .txt file, I used the "capture.output" function. I've made several a lot of trials with 'write.table', but with no use. Not sure why. the output of this step is "tidy_data.txt"