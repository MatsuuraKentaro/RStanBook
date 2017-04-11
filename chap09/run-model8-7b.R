library(rstan)

d <- read.csv('../chap08/input/data-conc-2.txt')
N <- nrow(d)
Time <- c(1, 2, 4, 8, 12, 24)
T_new <- 60
Time_new <- seq(from=0, to=24, length=T_new)
data <- list(N=N, T=length(Time), Time=Time, Y=d[,-1], T_new=T_new, Time_new=Time_new)
fit <- stan(file='model/model8-7b.stan', data=data, seed=1234)
