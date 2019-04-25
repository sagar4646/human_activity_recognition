# Human activity recognition
# LIBRARY ####
library(dplyr)
library(tidyr)
#  DATA #####
# activity table
activity_label=read.table("./data/activity_labels.txt",col.names = c("id","activity"))
# features table
feature=read.table("./data/features.txt",col.names = c("id","feature"),stringsAsFactors = F)
# train
train_y=read.table("./data/train/y_train.txt",col.names = "activity_id")
train_x=read.table("./data/train/x_train.txt",col.names = feature$feature)
train_subject=read.table("./data/train/subject_train.txt",col.names = "subject")

# test
test_y=read.table("./data/test/y_test.txt",col.names = "activity_id")
test_x=read.table("./data/test/x_test.txt",col.names = feature$feature)
test_subject=read.table("./data/test/subject_test.txt",col.names = "subject")
# bind the *_x and *_y into single data frame
train=cbind(train_x,train_subject,train_y)
test=cbind(test_x,test_subject,test_y)

# merge the train and test into one data frame #####
data=rbind(train,test)

# extract the mean and sd column of each feature ####
cols_extract=grep("mean\\.|std",colnames(data),value = T) # '\\.'is used in order to prevent meanFreq
extract_cols=c(cols_extract,colnames(data[562:563]))  # adding subject and activity_id for subsetting

data_tidy=data[extract_cols]

# naming the activity ######

data_tidy=merge(data_tidy,activity_label,by.x = "activity_id",by.y = "id") # assigning the activity
data_tidy=data_tidy[-1]   # removing the activity_id

# naming variables #####

cols=grep("mean\\(|std",feature$feature,value = T) # '\\(' is used in order to prevent meanFreq() 
rename_cols=c(cols,colnames(data_tidy[67:68]))  # adding subject and activity 

colnames(data_tidy)=rename_cols

# avg of each variabl for each activity and each subject #####

split_data=split(data_tidy[1:66],interaction(data_tidy$activity,data_tidy$subject))
avg_data=as.data.frame(sapply(split_data,function(x){sapply(x,mean)}))

# reshaping
avg_data=avg_data%>%
    mutate(feature=row.names(avg_data))%>%
    gather("key","value",1:180)%>%
    spread(feature,value)%>%
    separate(key,c("activity","subject"),sep="\\.")%>%
    select(3:68,2,1)

# writing data into txt
write.table(avg_data,"averages.txt",row.names = F)
avg_data