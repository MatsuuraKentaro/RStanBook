library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

T <- 96
d_ori <- as.matrix(read.csv('../input/data-2Dmesh.txt', header=FALSE))
I <- nrow(d_ori)
J <- ncol(d_ori)
TID <- read.csv('../input/data-2Dmesh-design.txt', header=FALSE)

stanmodel <- stan_model(file='../model/model12-13.stan')

res <- lapply(c(0.1, 0.2, 0.3), function(s_add) {
  set.seed(1234)
  d <- matrix(rnorm(length(d_ori), mean=d_ori, sd=s_add), ncol=J)
  rownames(d) <- 1:I
  colnames(d) <- 1:J
  d_melt <- reshape2::melt(d)
  colnames(d_melt) <- c('i','j','Y')
  loess_res <- loess(Y ~ i + j, data=d_melt, span=0.1)
  smoothed <- matrix(loess_res$fitted, nrow=I, ncol=J)

  data <- list(I=I, J=J, Y=d, T=T, TID=TID)
  fit <- sampling(
    stanmodel, data=data, iter=5000, thin=5, seed=1234,
    init=function() {
      list(r=smoothed, s_r=1, s_Y=1, s_beta=1, beta=rnorm(T,0,0.1))
    }
  )
})
