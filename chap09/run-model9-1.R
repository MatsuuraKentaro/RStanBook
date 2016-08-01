library(rstan)

d <- read.csv('../chap04/input/data-salary.txt')
data <- list(N=nrow(d), X=d$X, Y=d$Y)
fit <- stan(file='model/model9-1.stan', data=data, seed=1234)
fit_b <- stan(file='model/model9-1b.stan', data=data, seed=1234)
