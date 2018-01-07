setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")

library(caTools)
library(ggplot2)
library(ElemStatLearn)

dataset<-read.csv('Social_Network_Ads.csv')
dataset<-dataset[3:5]

set.seed(123)
split=sample.split(dataset$Purchased,SplitRatio = 0.75)

training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

training_set[,1:2]<-scale(training_set[,1:2])
test_set[,1:2]<-scale(test_set[,1:2])


#Logistic regression
classifier=glm(formula=Purchased~.,
               family = binomial,
               data=training_set)

#predict values
prob_pred=predict(classifier,type = 'response',newdata = test_set[-3])
y_pred=ifelse(prob_pred>0.5,1,0)

#Confusion Matrix

cm=table(test_set[,3],y_pred)


#Visualizing results

# Visualising the Training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = 'Classifier (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

# Visualising the Test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3], main = 'Classifier (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))


