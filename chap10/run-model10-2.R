library(rstan)

d <- read.csv(file='input/data-category.txt')
d$Age <- d$Age/100
d$Income <- d$Income/1000
X <- cbind(1, d[,-ncol(d)])
data <- list(N=nrow(d), D=ncol(X), K=6, X=X, Y=d$Y)
fit <- stan(file='model/model10-2.stan', data=data, pars=c('b_raw'), seed=1234)
