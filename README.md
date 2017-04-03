# minihack-machine-learning
HI so this one of the competition where we (Team Name : things should getter better *sorry for the typo) after the first submission where we scored around ~0.85 , we tried to improve the score by removing the ids , stock ids and timestamp and a single xgboost model run give us the score of ~0.692 (first rank among the seven participants ) so we try to improve the thing by adding few of the features like :
 difference between the 5th day moving average and third moving average
 difference between the 10th and 5th moving average
 difference between 20th and 10th moving average 
 divide average true range and true range
 and one of the features which was added later was positive directional movement and anerage true range and negative true range which give us a lift of 0.678310 on a public leaderboard secured 10th position and on private leaderboard it was 0.679020 so slight overfit of the model maybe we include reductant variable and single xgb model improved our score .
 
