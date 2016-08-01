library(rstan)

d <- read.csv(file='input/data-attendance-2.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, M=d$M)
# fit <- stan(file='model/model5-6.stan', data=data, seed=1234)
fit <- stan(file='model/model5-6b.stan', data=data, seed=1234)

save.image('output/result-model5-6.RData')
