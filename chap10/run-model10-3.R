library(rstan)

d <- read.csv(file='input/data-usagitokame.txt')
data <- list(N=2, G=nrow(d), LW=d)
fit <- stan(file='model/model10-3.stan', data=data, pars=c('b'), seed=1234)
