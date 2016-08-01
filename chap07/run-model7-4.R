library(rstan)

d <- read.csv('input/data-conc.txt')
T_new <- 60
Time_new <- seq(from=0, to=24, length=T_new)
data <- list(T=nrow(d), Time=d$Time, Y=d$Y, T_new=T_new, Time_new=Time_new)
fit <- stan(file='model/model7-4.stan', data=data, seed=123)

save.image('output/result-model7-4.RData')
