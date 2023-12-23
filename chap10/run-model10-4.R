library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv(file='input/data-shogi-player.txt')
N <- max(d)
G <- nrow(d)
data <- list(N=N, G=G, LW=d)

stanmodel <- stan_model(file='model/model10-4.stan')
fit <- sampling(stanmodel, data=data, pars=c('mu','s_mu','s_pf'), seed=1234)

ms <- rstan::extract(fit)
qua <- apply(ms$mu, 2, quantile, prob=c(0.05, 0.5, 0.95))
d_est <- data.frame(nid=1:N, t(qua), check.names=FALSE)
d_top5 <- head(d_est[rev(order(d_est$`50%`)),], 5)
# nid        5%      50%      95%
#  47 1.5714078 1.868790 2.204545
# 105 1.3110919 1.612636 1.967448
# 134 1.0479643 1.337389 1.658967
#  78 1.0090331 1.303693 1.637110
#  65 0.9835042 1.282803 1.604898

qua <- apply(ms$s_pf, 2, quantile, prob=c(0.05, 0.5, 0.95))
d_est <- data.frame(nid=1:N, t(qua), check.names=FALSE)
d_top3 <- head(d_est[rev(order(d_est$`50%`)),], 3)
d_bot3 <- head(d_est[order(d_est$`50%`),], 3)
# nid        5%      50%      95%
# 155 0.8346475 1.299498 1.922007
#  53 0.7572167 1.240500 1.807479
# 130 0.7775759 1.218723 1.783369

# nid        5%       50%      95%
# 106 0.4059646 0.7278221 1.139531
# 162 0.4381930 0.7876454 1.274487
# 132 0.4573107 0.8034746 1.274778

save.image('output/result-model10-4.RData')
