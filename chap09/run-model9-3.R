library(rstan)

d <- read.csv(file='input/data-attendance-5.txt')
d$Score <- d$Score/200
X <- cbind(1, d[,-ncol(d)])
data <- list(N=nrow(d), D=ncol(X), X=X, Y=d$Y)
fit <- stan(file='model/model9-3.stan', data=data, seed=1234)
