library(rstan)

fit_a <- stan(file='model/model10-8a.stan', seed=1234, chains=1, iter=4000)
fit_b <- stan(file='model/model10-8b.stan', seed=1234, chains=1, iter=4000)
