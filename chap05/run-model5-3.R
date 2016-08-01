library(rstan)

d <- read.csv(file='input/data-attendance-1.txt')
data <- list(N=nrow(d), A=d$A, Score=d$Score/200, Y=d$Y)
fit <- stan(file='model/model5-3.stan', data=data, seed=1234)

save.image('output/result-model5-3.RData')
