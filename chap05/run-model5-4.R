library(rstan)

d <- read.csv(file='input/data-attendance-2.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, M=d$M, Y=d$Y)
fit <- stan(file='model/model5-4.stan', data=data, seed=1234)

save.image('output/result-model5-4.RData')
