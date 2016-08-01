library(rstan)

d <- read.csv('input/data-salary-2.txt')
N <- nrow(d)
K <- 4
data <- list(N=N, X=d$X, Y=d$Y, KID=d$KID)
fit2 <- stan(file='model/model8-2.stan', data=data, seed=1234)

save.image('output/result-model8-2.RData')
