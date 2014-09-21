library("data.table")
library("reshape2")
table1 <- read.table("./Unit2/project/UCI HAR Dataset/activity_labels.txt")[,2]
table2 <- read.table("./Unit2/project/UCI HAR Dataset//features.txt")[,2]
table3 <- grepl("mean|std", table2)
table4 <- read.table("./Unit2/project/UCI HAR Dataset/test/X_test.txt")
table5 <- read.table("./Unit2/project/UCI HAR Dataset/test/y_test.txt")
table6 <- read.table("./Unit2/project/UCI HAR Dataset/test/subject_test.txt")
names(table4) = table2
table4 = table4[,table3]
table5[,2] = table1[table5[,1]]
names(table5) = c("Activity_ID", "Activity_Label")
names(table6) = "subject"
testes <- cbind(as.data.table(table6), table5, table4)
table7 <- read.table("./Unit2/project/UCI HAR Dataset/train/X_train.txt")
table8 <- read.table("./Unit2/project/UCI HAR Dataset/train/y_train.txt")
table9 <- read.table("./Unit2/project/UCI HAR Dataset/train/subject_train.txt")
names(table7) = table2
table7 = table7[,table3]
table8[,2] = table1[table8[,1]]
names(table8) = c("Activity_ID", "Activity_Label")
names(table9) = "subject"
testes2 <- cbind(as.data.table(table9), table8, table7)
combinado = rbind(testes, testes2)
idlabels   = c("subject", "Activity_ID", "Activity_Label")
datal = setdiff(colnames(combinado), idlabels)
mdata      = melt(combinado, id = idlabels, measure.vars = datal)
organizado   = dcast(mdata, subject + table1 ~ variable, mean)
write.table(organizado, file = "./Unit2/project/tidy_data.txt")
