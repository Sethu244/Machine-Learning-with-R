setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")


# Importing the dataset
dataset = read.csv('Churn_Modelling.csv')
dataset = dataset[4:14]

# Encoding the target feature as factor
dataset$Geography = as.numeric(factor(dataset$Geography,
                                      levels = c('France','Spain','Germany'),
                                      labels = c(1,2,3)))


dataset$Gender =as.numeric(factor(dataset$Gender,
                                  levels = c('Female','Male'),
                                  labels = c(1,2)))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])

# Fitting ANN to the Training set

#install.packages("h2o", type="source", repos="http://h2o-release.s3.amazonaws.com/h2o/rel-wheeler/2/R")

# Finally, let's load H2O and start up an H2O cluster
library(h2o)

h2o.init(nthreads=-1)
classifier<-h2o.deeplearning(y='Exited',
                             training_frame=as.h2o(training_set),
                             activation='Rectifier',
                             hidden=c(6,6),
                             epochs=100,
                             train_samples_per_iteration = -2)


# Predicting the Test set results
prob_predict = h2o.predict(classifier, newdata =as.h2o(test_set[-11]))
y_pred=(prob_predict>0.5)
y_pred=as.vector(y_pred)

# Making the Confusion Matrix
cm = table(test_set[,11], y_pred)

h2o.shutdown()
