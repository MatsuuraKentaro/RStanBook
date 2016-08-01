library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv('input/data-changepoint.txt')
T <- nrow(d)
data <- list(T=T, Y=d$Y)
stanmodel <- stan_model(file='model/model12-7.stan')
fit <- sampling(stanmodel, data=data, pars=c('mu', 's_mu', 's_Y'), seed=1234)

save.image('output/result-model12-7.RData')
