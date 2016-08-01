library(rstan)

d <- read.csv(file='../../chap05/input/data-attendance-1.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, Y=d$Y)
fit <- stan(file='ex1.stan', data=data, seed=1234)
