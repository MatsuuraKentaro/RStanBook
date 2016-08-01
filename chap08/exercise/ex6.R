library(rstan)

d <- read.csv('../input/data7a.csv')
N <- nrow(d)
data <- list(N=N, Y=d$y)
fit <- stan(file='ex6.stan', data=data, seed=1234)
