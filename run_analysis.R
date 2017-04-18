# read activity labels
actlabels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

xtrain <- read.table("./train/X_train.txt")
xtest <- read.table("./test/X_test.txt")
xdata <- rbind(xtest, xtrain)
# Define Column Names based on features read from features.txt
xdata <- setNames(xdata, features[,2])

ytest <- read.table("./test/y_test.txt")
ytrain <- read.table("./train/y_train.txt")
ydata <- rbind(ytest, ytrain)
ydata <- merge(ydata, actlabels, by.x='V1', by.y='V1')
ydata$V1 <- NULL
ydata <- setNames(ydata, c('label'))


body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
body_acc_x <- rbind(body_acc_x_test,body_acc_x_train)
names(body_acc_x) <- paste0('body_acc_x_', gsub('^V', '', names(body_acc_x)))
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
body_acc_y <- rbind(body_acc_y_test,body_acc_y_train)
names(body_acc_y) <- paste0('body_acc_y_', gsub('^V', '', names(body_acc_y)))
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
body_acc_z <- rbind(body_acc_z_test,body_acc_z_train)
names(body_acc_z) <- paste0('body_acc_z_', gsub('^V', '', names(body_acc_z)))

body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_x <- rbind(body_gyro_x_test,body_gyro_x_train)
names(body_gyro_x) <- paste0('total_acc_x_', gsub('^V', '', names(total_acc_x)))
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_y <- rbind(body_gyro_y_test,body_gyro_y_train)
names(body_gyro_y) <- paste0('total_acc_y_', gsub('^V', '', names(total_acc_y)))
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")
body_gyro_z <- rbind(body_gyro_z_test,body_gyro_z_train)
names(body_gyro_z) <- paste0('total_acc_z_', gsub('^V', '', names(total_acc_z)))


total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
total_acc_x <- rbind(total_acc_x_test,total_acc_x_train)
names(total_acc_x) <- paste0('total_acc_x_', gsub('^V', '', names(total_acc_x)))
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
total_acc_y <- rbind(total_acc_y_test,total_acc_y_train)
names(total_acc_y) <- paste0('total_acc_y_', gsub('^V', '', names(total_acc_y)))
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")
total_acc_z <- rbind(total_acc_z_test,total_acc_z_train)
names(total_acc_z) <- paste0('total_acc_z_', gsub('^V', '', names(total_acc_z)))

subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
subject_data <- rbind(subject_test, subject_train)
subject_data <- setNames(subject_data, c('subject'))

data <- cbind(body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z, xdata, ydata, subject_data)

# Extract only the measurements related to mean and std
data_mean_std <- subset(data, select = grep("?mean()?|?std()?|label|subject", names(data)))

# Aggregate average on each activity & each subject into a second tidy data set
data_2_mean_by_subject_label <- data_mean_std %>% group_by(subject,label) %>% summarise_each(funs(mean))

