library(rstan)

d <- read.csv('../../chap08/input/data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID
data <- list(N=N, G=G, K=K, X=d$X, Y=d$Y, KID=d$KID, K2G=K2G)
fit <- stan(file='ex4.stan', data=data, seed=1234)
