## assignment says assume the data is in the working directory, but go ahead and
## read file from internet and unzip to make sure everything is in the right place
## 
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(temp)
unlink(temp)

## load required packages
#require(stringr)
require(plyr)

## read in the features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("f_id", "feature"))
# clean up the features list to get rid of "()" and ")" and replace "-", "(" or "," 
# with a "_". could have used stringr, but nested gsub() works.
flist <- with(features, gsub("-|\\(|,", "_", gsub("\\(\\)|\\)", "", feature)))
activity_lbl <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("a_id", "activity"))

## read in the test data
testx <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = flist)
testy <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("a_id"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))

## create the testing data frame. use cbind to preserve the order of the observations
ctest <- cbind(subject_test, testy, testx)

## read in the train data
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = flist)
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("a_id"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

## create the training data frame
ctrain <- cbind(subject_train, trainy, trainx)

## rbind the test and train data, then merge in the activity labels
df <- rbind(ctest, ctrain)
df <- merge(activity_lbl, df, by="a_id")

## create a list of the columns we want to keep. assignment was unclear whether meanFreq() and
## gravityMean should be included, but it doesn't seem to make sense for the data, so leaving
## them out. to include them, you would just change to grep("[Mm]ean|_std")
thelist <- c(grep("_mean[^F]|_std", names(df)))

## create the a tidy data frame--this one is not for upload. wanted a more elegant way
## to order the first two fields, but 3:2 works and it's late....
tidy1 <- df[, c(3:2, thelist)]

## create the mean for all the variables
tidy2 <- ddply(tidy1, .(subject, activity), numcolwise(mean))

## easy to create a long dataset with melt(), but we'll keep it wide
# write data frame to  tab delimited text file
write.table(tidy2, "tidy.txt", sep="\t", row.names=FALSE)
