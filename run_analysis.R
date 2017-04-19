# Loading the data

## load labels and features
actlabels <- read.table("./activity_labels.txt") # reading activity labels
features <- read.table("./features.txt") # reading features

## load X data sets
xtrain <- read.table("./train/X_train.txt") # reading training data for X
xtest <- read.table("./test/X_test.txt") # reading test data for X

## load y data sets
ytest <- read.table("./test/y_test.txt") # reading test data for y
ytrain <- read.table("./train/y_train.txt") # reading training data for y

## load body acceleration data sets
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")

## load body gyro measurements data sets
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")

## load total acc data sets
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")

## load subject data sets
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")

# Data Manipulation
## Manipulations for X
xdata <- rbind(xtest, xtrain) # Combining training and test data set for X
xdata <- setNames(xdata, features[,2]) # Define Column Names based on features read from features.txt

## Manipulations for y
ydata <- rbind(ytest, ytrain) # Combining training and test data set for y
ydata <- merge(ydata, actlabels, by.x='V1', by.y='V1') # Merge data set for y with activity labels
ydata$V1 <- NULL # remove column V1 as not needed
ydata <- setNames(ydata, c('label')) # Assign Column Name 'label' to data set for y (only 1 column)

## Manipulations for body acc (x,y,z)
body_acc_x <- rbind(body_acc_x_test,body_acc_x_train) # combine training and test data set for x
names(body_acc_x) <- paste0('body_acc_x_', gsub('^V', '', names(body_acc_x))) # Beautify Labels by remove V and adding proper description
body_acc_y <- rbind(body_acc_y_test,body_acc_y_train) # combine training and test data set for y
names(body_acc_y) <- paste0('body_acc_y_', gsub('^V', '', names(body_acc_y))) # Beautify Labels by remove V and adding proper description
body_acc_z <- rbind(body_acc_z_test,body_acc_z_train) # combine training and test data set for z
names(body_acc_z) <- paste0('body_acc_z_', gsub('^V', '', names(body_acc_z))) # Beautify Labels by remove V and adding proper description

## Manipulations for body gyro measurements (x,y,z)
body_gyro_x <- rbind(body_gyro_x_test,body_gyro_x_train) # combine training and test data set for x
names(body_gyro_x) <- paste0('total_acc_x_', gsub('^V', '', names(total_acc_x))) # Beautify Labels by remove V and adding proper description
body_gyro_y <- rbind(body_gyro_y_test,body_gyro_y_train) # combine training and test data set for y
names(body_gyro_y) <- paste0('total_acc_y_', gsub('^V', '', names(total_acc_y))) # Beautify Labels by remove V and adding proper description
body_gyro_z <- rbind(body_gyro_z_test,body_gyro_z_train) # combine training and test data set for z
names(body_gyro_z) <- paste0('total_acc_z_', gsub('^V', '', names(total_acc_z))) # Beautify Labels by remove V and adding proper description

## Manipulations for total acceleration (x,y,z)
total_acc_x <- rbind(total_acc_x_test,total_acc_x_train) # combine training and test data set for x
names(total_acc_x) <- paste0('total_acc_x_', gsub('^V', '', names(total_acc_x))) # Beautify Labels by remove V and adding proper description
total_acc_y <- rbind(total_acc_y_test,total_acc_y_train) # combine training and test data set for y
names(total_acc_y) <- paste0('total_acc_y_', gsub('^V', '', names(total_acc_y))) # Beautify Labels by remove V and adding proper description
total_acc_z <- rbind(total_acc_z_test,total_acc_z_train) # combine training and test data set for z
names(total_acc_z) <- paste0('total_acc_z_', gsub('^V', '', names(total_acc_z))) # Beautify Labels by remove V and adding proper description

## Manipulate Subject Data Set
subject_data <- rbind(subject_test, subject_train) # Combine training and test data for subject
subject_data <- setNames(subject_data, c('subject')) # Assign column name 'subject' to subject data set

# Bring all together in one data set
data <- cbind(body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z, xdata, ydata, subject_data)

# Extract only the measurements related to mean and std
data_mean_std <- subset(data, select = grep("?mean()?|?std()?|label|subject", names(data)))

# Aggregate average on each activity & each subject into a second tidy data set
data_2_mean_by_subject_label <- data_mean_std %>% group_by(subject,label) %>% summarise_each(funs(mean))

# Write data set 2 to .txt file
write.table(data_2_mean_by_subject_label,"data_2_mean_by_subject_label.txt",sep="\t",row.name=FALSE)
