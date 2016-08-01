library(rstan)

d <- read.csv(file='input/data-rental.txt')
colnames(d) <- c('Y', 'X')
X_new <- seq(from=10, to=120, length=50)
data <- list(N=nrow(d), Area=log10(d$X), Y=log10(d$Y), N_new=50, Area_new=log10(X_new))
fit <- stan(file='model/model7-2.stan', data=data, seed=1234)

save.image('output/result-model7-2.RData')
