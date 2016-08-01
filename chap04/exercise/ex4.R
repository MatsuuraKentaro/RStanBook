library(rstan)

load('result-ex3.RData')

ms <- extract(fit)

prob <- mean(ms$mu1 < ms$mu2)  #=> 0.9325

# N_mcmc <- length(ms$mu1)
# prob <- sum(ms$mu1 < ms$mu2)/N_mcmc  #=> 0.9325