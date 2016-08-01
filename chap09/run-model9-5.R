library(rstan)

K <- 6
d <- read.csv(file='input/data-dice.txt')
Y <- table(factor(d$Face, levels=1:K))
data <- list(K=K, Y=Y)
fit <- stan(file='model/model9-5.stan', data=data, seed=1234)
