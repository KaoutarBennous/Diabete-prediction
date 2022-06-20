
# Importing libraries
library(randomForest)
library(caret)

# Importing the data set
  datas <- read.csv("diabetes.csv")

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(datas$Outcome, p=0.8, list = FALSE)
TrainingSet <- datas[TrainingIndex,] # Training Set
TestingSet <- datas[-TrainingIndex,] # Test Set

write.csv(TrainingSet, "training.csv")
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Building Random forest model

model <- randomForest(as.factor(Outcome) ~ ., data = TrainSet, ntree = 500, mtry = 6, importance = TRUE)

# Save model to RDS file
saveRDS(model, "model.rds")
