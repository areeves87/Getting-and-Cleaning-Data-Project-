  library(dplyr)
  
  #Load the raw data for train & test set, activity labels, feature labels
  setwd("~/coursera/GettingCleaningData/Assignment/UCI HAR Dataset")
  activity_labels<-read.table("./activity_labels.txt")
  features<-read.table("./features.txt")
  X_train<-read.table("./train/X_train.txt")
  Y_train<-read.table("./train/Y_train.txt")
  subject_train<-read.table("./train/subject_train.txt")
  subject_test<-read.table("./test/subject_test.txt")
  X_test<-read.table("./test/X_test.txt")
  Y_test<-read.table("./test/Y_test.txt")
  
  #Give features descriptive variable names; activities described w/ labeled levels
  colnames(X_train)<-features$V2;colnames(X_test)<-features$V2
  colnames(subject_train)<-"id";colnames(subject_test)<-"id"
  colnames(Y_train)<-"activity";colnames(Y_test)<-"activity"
  Y_train$activity<-as.factor(Y_train$activity);Y_test$activity<-as.factor(Y_test$activity)
  levels(Y_train$activity)<-activity_labels$V2;levels(Y_test$activity)<-activity_labels$V2
  
  #bind columns within train and test sets
  X_train<-cbind(subject_train,Y_train,X_train);X_test<-cbind(subject_test,Y_test,X_test)
  
  #add column to indicate train or test set
  X_train<-cbind(set=1,X_train);X_test<-cbind(set=2,X_test)
  X_train$set<-as.factor(X_train$set);X_test$set<-as.factor(X_test$set)
  levels(X_train$set)<-"train";levels(X_test$set)<-"test"
  
  #combine train and test sets
  df_test<-rbind(X_train,X_test)
  
  #select only these columns: set,id,activity,means,stds
  mean_std_names<-grep("set|id|activity|mean[()]|std[()]",names(df_test),value=TRUE)
  df_test<-df_test[,mean_std_names]
  
  #check for NAs
  colSums(is.na(df_test));all(colSums(is.na(df_test))==0)
  
  #create 2nd, independent tidy dataset summarizing column means grouped by id and activity
  tidy_data<-df_test %>% 
                group_by(id,activity) %>%
                  summarise_each(funs(mean(., na.rm=TRUE)),-(set:activity))
  
  write.table(tidy_data,file = "./tidy.txt", row.name=FALSE)
  tidy<-read.table("./tidy.txt", header=TRUE)
  
  # #melt the data into long form
  # melted_tidy<-melt(tidy_data,id=c("id","activity"))
  # melted_tidy<-arrange(melted_tidy,id,activity,variable)
  # names(melted_tidy)[3:4]<-c("feature","average value")
  # 
  # #cast the data back into wide form
  # casted_tidy<-dcast(melted_tidy,...~feature)
  