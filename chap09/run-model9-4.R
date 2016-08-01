library(rstan)

K <- 6
d <- read.csv(file='input/data-dice.txt')
d_count <- table(factor(d$Face, levels=1:K))
data <- list(N=nrow(d), K=K, Y=d$Face)
fit <- stan(file='model/model9-4.stan', data=data, seed=1234)
