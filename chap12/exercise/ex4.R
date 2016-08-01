library(rstan)

T <- 96
d_ori <- as.matrix(read.csv('../input/data-2Dmesh.txt', header=FALSE))
I <- nrow(d_ori)
J <- ncol(d_ori)
TID <- read.csv('../input/data-2Dmesh-design.txt', header=FALSE)
s_add <- 0.3

set.seed(1234)
d <- matrix(rnorm(length(d_ori), mean=d_ori, sd=s_add), ncol=J)
rownames(d) <- 1:I
colnames(d) <- 1:J
d_melt <- reshape2::melt(d)
colnames(d_melt) <- c('i','j','Y')
loess_res <- loess(Y ~ i + j, data=d_melt, span=0.1)
smoothed <- matrix(loess_res$fitted, nrow=I, ncol=J)

stanmodel <- stan_model(file='ex4.stan')

data <- list(I=I, J=J, Y=d, T=T, TID=TID, S_s_Y=0.1)
fit <- sampling(
  stanmodel, data=data, iter=5000, thin=5, seed=1234,
  init=function() {
    list(r=smoothed, s_r=1, s_Y=1, s_beta=1, beta=rnorm(T,0,0.1))
  }
)

ms <- rstan::extract(fit)
r_median <- apply(ms$r, c(2,3), median)
png('fig-ex4.png', pointsize=72, width=2400, height=2100)
persp(1:I, 1:J, r_median, theta=55, phi=40, expand=0.5, border='black', col='grey95', xlab='Plate Row', ylab='Plate Column', zlab='r', ticktype='detailed', lwd=2)
dev.off()
