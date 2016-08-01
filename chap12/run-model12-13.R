library(rstan)

T <- 96
d <- as.matrix(read.csv('input/data-2Dmesh.txt', header=FALSE))
I <- nrow(d)
J <- ncol(d)
rownames(d) <- 1:I
colnames(d) <- 1:J
d_melt <- reshape2::melt(d)
colnames(d_melt) <- c('i','j','Y')

loess_res <- loess(Y ~ i + j, data=d_melt, span=0.1)
smoothed <- matrix(loess_res$fitted, nrow=I, ncol=J)
TID <- read.csv('input/data-2Dmesh-design.txt', header=FALSE)
data <- list(I=I, J=J, Y=d, T=T, TID=TID)

stanmodel <- stan_model(file='model/model12-13.stan')
fit <- sampling(
  stanmodel, data=data, iter=5000, thin=5, seed=1234,
  init=function() {
    list(r=smoothed, s_r=1, s_Y=1, s_beta=1, beta=rnorm(T,0,0.1))
  }
)

save.image('output/result-model12-13.RData')

stanmodel_b <- stan_model(file='model/model12-13b.stan')
fit_b <- sampling(
  stanmodel_b, data=data, iter=5000, thin=5, seed=1234,
  init=function() {
    list(r=smoothed, s_r=1, s_Y=1, s_beta=1, beta=rnorm(T,0,0.1))
  }
)
