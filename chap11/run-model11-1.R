library(rstan)

d <- read.csv(file='input/data-coin.txt')
data <- list(N=nrow(d), Y=d$Y)
fit <- stan(file='model/model11-1.stan', data=data, seed=1234)
