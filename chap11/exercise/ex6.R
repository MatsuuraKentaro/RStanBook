library(rstan)

d_ori <- read.csv('../input/data-lda.txt')
d <- subset(data.frame(table(d_ori)), Freq >= 1)
d$PersonID <- as.integer(as.character(d$PersonID))
d$ItemID <- as.integer(as.character(d$ItemID))

E <- nrow(d); N <- 50; K <- 6; I <- 120
data <- list(
  E=nrow(d), N=N, I=I, K=K,
  PersonID=d$PersonID, ItemID=d$ItemID, Freq=d$Freq, Alpha=rep(0.5, I)
)

stanmodel <- stan_model(file='ex6.stan')
fit_vb <- vb(stanmodel, data=data, seed=123)
