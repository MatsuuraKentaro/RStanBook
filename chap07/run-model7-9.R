library(rstan)

d <- read.csv(file='input/data-outlier.txt')
X_new <- seq(from=0, to=11, length=100)
data <- list(N=nrow(d), X=d$X, Y=d$Y, N_new=length(X_new), X_new=X_new)
fit <- stan(file='model/model7-9.stan', data=data, seed=1234)

save.image('output/result-model7-9.RData')
