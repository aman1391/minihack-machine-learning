
library(ggplot2)
library(xgboost)
library(data.table)
library(caret)
###load the data set
X_train<- fread("train.csv")
X_test<- fread("test.csv")
sample<- fread("sample.csv")
####
X_All<- plyr::rbind.fill(X_train,X_test)
##
str(X_All)
table(is.na(X_All))
X_All$ID<- NULL
X_All$Outcome<- NULL
#####
y<- X_train$Outcome
ID<- X_test$ID
####
X_All[is.na(X_All)]<- -1
X_All$feature5_3=X_All$Five_Day_Moving_Average-X_All$Three_Day_Moving_Average
X_All$feature10_5=X_All$Ten_Day_Moving_Average-X_All$Five_Day_Moving_Average
X_All$feature20_10=X_All$Twenty_Day_Moving_Average-X_All$Ten_Day_Moving_Average
X_All$feature<- X_All$Average_True_Range/X_All$True_Range
X_All$feature_1<- X_All$Positive_Directional_Movement/X_All$Average_True_Range
X_All$feature_2<- X_All$Negative_Directional_Movement/X_All$Average_True_Range
X_All$timestamp<- NULL
####
X_All$Stock_ID<- NULL
###
#x2<- t(apply(X_All,1,combn,3,prod))
#x3 <- t(apply(X_All, 1, combn, 2, prod))
#x4<- t(apply(X_All,1,combn,4,prod))
#colnames(x2) <- paste("Inter.V", combn(1:13, 3, paste, collapse="V"), sep="")
#colnames(x4) <- paste("Inter.V", combn(1:12, 4, paste, collapse="V"), sep="")
#rm(X_train,X_test)
#colnames(x3) <- paste("Inter.V", combn(1:13, 2, paste, collapse="V"), sep="")
#X_all_1<- cbind(X_All,x3)
####model
X_train_1<- X_All[1:nrow(X_train),]
X_test_1<- X_All[-(1:nrow(X_train)),]
###modelling part basic one
model_xgb_cv <- xgb.cv(data=data.matrix(X_train_1), label=data.matrix(y), objective="binary:logistic", nfold=5, nrounds=250, eta=0.06, max_depth=6, subsample=0.950, colsample_bytree=0.98, min_child_weight=1, eval_metric="logloss")
model_xgb <- xgboost(data=data.matrix(X_train_1), label=data.matrix(y), objective="binary:logistic", nrounds=500, eta=0.04,  max_depth=6, subsample=0.95, colsample_bytree=0.98, min_child_weight=1, eval_metric="logloss")
pre_1<- predict(model_xgb,data.matrix(X_test_1))
sub_1<- data.frame(ID=ID,Outcome=pre_1)
write.csv(sub_1,'sub_27.csv',row.names = F) 

