library(rstan)

d <- read.csv(file='../../chap05/input/data-attendance-2.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, M=d$M)
fit <- stan(file='ex2.stan', data=data, seed=1234)
