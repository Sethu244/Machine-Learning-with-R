setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")

library(arules)

dataset<-read.csv('Market_Basket_Optimisation.csv',header = FALSE)


dataset=read.transactions('Market_Basket_Optimisation.csv',sep = ',',rm.duplicates = TRUE)

summary(dataset)


itemFrequencyPlot(dataset,topN=10)


#Training dataset

rules<-apriori(dataset,parameter = list(support=((3*7)/7500),confidence = 0.2))


#visualizing the rules

inspect(sort(rules,by='lift')[0:10])