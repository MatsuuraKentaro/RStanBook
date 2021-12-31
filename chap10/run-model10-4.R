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
#     nid        5%      50%      95%
# 47   47 1.5726996 1.865343 2.190407
# 105 105 1.3118989 1.608619 1.927458
# 134 134 1.0411699 1.330856 1.654713
# 78   78 1.0145620 1.295185 1.619833
# 65   65 0.9930503 1.268732 1.574958

qua <- apply(ms$s_pf, 2, quantile, prob=c(0.05, 0.5, 0.95))
d_est <- data.frame(nid=1:N, t(qua), check.names=FALSE)
d_top3 <- head(d_est[rev(order(d_est$`50%`)),], 3)
d_bot3 <- head(d_est[order(d_est$`50%`),], 3)
#     nid        5%      50%      95%
# 155 155 0.7813798 1.265033 1.866735
# 53   53 0.7551057 1.223627 1.784212
# 130 130 0.7853743 1.221336 1.772911

#     nid        5%       50%      95%
# 106 106 0.4053094 0.7184084 1.145521
# 78   78 0.4710745 0.7729856 1.210645
# 162 162 0.4389077 0.7804758 1.230150

save.image('output/result-model10-4.RData')
