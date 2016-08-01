library(rstan)

d <- read.csv('input/data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID
data5 <- list(N=N, G=G, K=K, X=d$X, Y=d$Y, KID=d$KID, K2G=K2G)
fit5 <- stan(file='model/model8-5.stan', data=data5, seed=12345)

save.image('output/result-model8-5.RData')
