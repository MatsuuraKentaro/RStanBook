library(rstan)

d <- read.csv(file='input/data-50m.txt', header=TRUE)
data <- list(N=nrow(d), Age=d$Age, Weight=d$Weight, Y=d$Y)
fit <- stan(file='model/model7-5.stan', data=data, seed=1234)
