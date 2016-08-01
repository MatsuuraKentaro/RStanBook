library(rstan)

d <- read.csv('../input/data-ss2.txt')
T <- nrow(d)
data <- list(T=T, T_pred=8, Y=d$Y)
stanmodel <- stan_model(file='ex2.stan')
fit <- sampling(stanmodel, data=data, iter=4000, thin=5, seed=1234)
