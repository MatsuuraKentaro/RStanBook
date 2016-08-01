library(rstan)

d <- read.csv(file='input/data-salary.txt')
data <- list(N=nrow(d), X=d$X, Y=d$Y)

stanmodel <- stan_model(file='model/model4-5.stan')

fit <- sampling(
  stanmodel,
  data=data,
  pars=c('b', 'sigma'),
  init=function() {
    list(a=runif(1,-10,10), b=runif(1,0,10), sigma=10)
  },
  seed=123,
  chains=3, iter=1000, warmup=200, thin=2
)
