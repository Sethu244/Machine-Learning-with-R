setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")

library(arules)

dataset=read.transactions('Market_Basket_Optimisation.csv',sep = ',',rm.duplicates = TRUE)

summary(dataset)

itemFrequencyPlot(dataset,topN=10)


#Training dataset

rules<-eclat(dataset,parameter = list(support=((3*7)/7500),minlen=2))


#visualizing the rules

inspect(sort(rules,by='support')[0:10])