library(rstan)

d <- read.csv('input/data-lda.txt')
E <- nrow(d)
N <- 50
K <- 6
I <- 120
data <- list(
  E=nrow(d), N=N, I=I, K=K,
  PersonID=d$PersonID, ItemID=d$ItemID, Alpha=rep(0.5, I)
)

stanmodel <- stan_model(file='model/model11-8.stan')
# fit_nuts <- sampling(stanmodel, data=data, seed=123)
fit_vb <- vb(stanmodel, data=data, seed=123)

save.image('output/result-model11-8.RData')