setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")


dataset<-read.csv("Mall_Customers.csv")

x<-dataset[4:5]

#Using Dendrogram

dendrogram=hclust(dist(x,method = "euclidean"),method = 'ward.D')

plot(dendrogram)

#Fitting Hierarchial clustering to dataset

hc=hclust(dist(x,method = "euclidean"),method = 'ward.D')

y_hc=cutree(hc,5)

#Visualaize

library(cluster)
clusplot(x,y_hc,lines=0,shade = TRUE,
         color = TRUE,labels = TRUE,
         plotchar = TRUE,span = TRUE)


