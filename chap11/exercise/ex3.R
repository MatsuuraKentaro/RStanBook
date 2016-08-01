library(rstan)

d <- read.csv(file='../input/data-coin.txt')
data <- list(N=nrow(d), Y=d$Y)
fit_A <- stan(file='ex3_A.stan', data=data, seed=1234)
fit_B <- stan(file='ex3_B.stan', data=data, seed=1234)
