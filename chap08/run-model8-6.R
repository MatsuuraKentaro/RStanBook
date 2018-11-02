library(rstan)

d <- read.csv('input/data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID
data6 <- list(N=N, G=G, K=K, X=d$X, Y=d$Y, KID=d$KID, GID=d$GID, K2G=K2G)
fit6 <- stan(file='model/model8-6.stan', data=data6, seed=12345)

save.image('output/result-model8-6.RData')
