library(rstan)

d <- read.csv(file='input/data-salary.txt')
data <- list(N=nrow(d), X=d$X, Y=d$Y)
fit <- stan(file='model/model4-5.stan', data=data, seed=1234)

save.image(file='output/result-model4-5.RData')
