library(rstan)

d <- read.csv('input/data-ZIP.txt')
d$Age <- d$Age/10
X <- cbind(1, d[,-ncol(d)])
data <- list(N=nrow(d), D=ncol(X), Y=d$Y, X=X)
fit <- stan(file='model/model11-7.stan', data=data,
  pars=c('b', 'q', 'lambda'), seed=1234)

ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)
r <- sapply(1:N_mcmc,
  function(i) cor(ms$lambda[i,], ms$q[i,], method='spearman'))
quantile(r, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
#    2.5%     25%     50%     75%   97.5%
# -0.7990 -0.6955 -0.6496 -0.6034 -0.4713