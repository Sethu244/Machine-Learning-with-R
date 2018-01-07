setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")


dataset<-read.csv("Mall_Customers.csv")

x<-dataset[4:5]

#using elbow method to choose clusters
set.seed(6)
wcss<-vector()
for(i in 1:10)
  wcss[i]<-sum(kmeans(x,i)$withinss)

plot(1:10,wcss,type='b')


#Apply K-means

set.seed(29)
kmeans<-kmeans(x,5,iter.max = 300,nstart = 10)

#Visualizations

library(cluster)
clusplot(x,kmeans$cluster,lines=0,shade = TRUE,
         color = TRUE,labels = TRUE,
         plotchar = TRUE,span = TRUE)


