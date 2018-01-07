setwd("D:\\Technology\\Data Sciences\\Machine Learing\\Udemy\\Machine Learning A-Z")


dataset<-read.csv('Ads_CTR_Optimisation.csv')

#Implementing UCB

N<-nrow(dataset)
d<-length(dataset)

ads_selected=integer()
number_of_selection<-integer(d)
sum_of_rewards=integer(d)
total_reward=0

for (n in 1:N){
  max_upper_bound=0
  ad=0
  for(i in 1:d){
    if(number_of_selection[i]>0){
      average_reward=(sum_of_rewards[i]/number_of_selection[i])
      delta_i<-sqrt((3/2)*(log(n)/number_of_selection[i]))
      upper_bound=average_reward+delta_i
    } else{
      upper_bound=1e400 
    }
   
    if(upper_bound>max_upper_bound){
      max_upper_bound=upper_bound
      ad=i
    }
  }
  ads_selected=append(ads_selected,ad)
  number_of_selection[ad]=  number_of_selection[ad]+1
  reward=dataset[n,ad]
  sum_of_rewards[ad]=sum_of_rewards[ad]+reward
  total_reward=total_reward+reward
}


# Visualising the results
hist(ads_selected,
     col = 'blue',
     main = 'Histogram of ads selections',
     xlab = 'Ads',
     ylab = 'Number of times each ad was selected')



