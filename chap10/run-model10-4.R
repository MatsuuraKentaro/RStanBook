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
d_qua <- data.frame(nid=1:N, t(apply(ms$mu, 2, quantile, prob=c(0.05, 0.5, 0.95))))
colnames(d_qua) <- c('nid', 'p05', 'p50', 'p90')
d_top5 <- head(d_qua[rev(order(d_qua$p50)),], 5)
#     nid    p05   p50   p90
# 47   47 1.5673 1.869 2.219
# 105 105 1.3075 1.607 1.936
# 134 134 1.0525 1.328 1.668
# 78   78 1.0067 1.304 1.633
# 65   65 0.9916 1.282 1.580


d_qua <- data.frame(nid=1:N, t(apply(ms$s_pf, 2, quantile, prob=c(0.05, 0.5, 0.95))))
colnames(d_qua) <- c('nid', 'p05', 'p50', 'p90')
d_top3 <- head(d_qua[rev(order(d_qua$p50)),], 3)
d_bot3 <- head(d_qua[order(d_qua$p50),], 3)
#     nid    p05   p50   p90
# 155 155 0.8120 1.306 1.911
# 130 130 0.8003 1.231 1.766
# 53   53 0.7386 1.223 1.838

#     nid    p05    p50   p90
# 106 106 0.4002 0.7393 1.216
# 78   78 0.4515 0.7778 1.252
# 162 162 0.4522 0.7845 1.279

save.image('output/result-model10-4.RData')
