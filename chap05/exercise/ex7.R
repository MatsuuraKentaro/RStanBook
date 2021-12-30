library(rstan)

d <- read.csv(file='../input/data4a.csv')
conv <- c(C=0, T=1)
data <- list(I=nrow(d), N=d$N, Y=d$y, X=d$x, F=conv[d$f])
fit <- stan(file='ex7.stan', data=data, seed=1234)
