library(rstan)

d <- read.csv('input/data-mix1.txt')
data <- list(N=nrow(d), Y=d$Y)
init <- list(a=0.5, mu=c(0,5), sigma=c(1,1))

stanmodel <- stan_model(file='model/model11-5.stan')
fit <- sampling(stanmodel, data=data, init=function(){ init }, seed=123)
