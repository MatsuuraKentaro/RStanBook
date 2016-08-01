library(rstan)

d <- read.csv('input/data-mix2.txt')
K <- 5
data <- list(N=nrow(d), K=K, Y=d$Y)
init <- list(a=rep(1,K)/K, mu=seq(10,40,len=K), s_mu=20, sigma=rep(1,K))

stanmodel <- stan_model(file='model/model11-6.stan')
fit <- sampling(stanmodel, data=data, init=function() init, seed=1234)

stanmodel_b <- stan_model(file='model/model11-6b.stan')
fit_b <- sampling(stanmodel_b, data=data, init=function() init, seed=1234)
