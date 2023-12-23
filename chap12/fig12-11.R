library(dplyr)
library(ggplot2)
library(ggrepel)

load('output/result-model12-14.RData')
ms <- rstan::extract(fit)

d_name <- read.csv('input/data-map-JIS.txt', header=FALSE, fileEncoding='UTF-8')
colnames(d_name) <- c('prefID', 'name')

qua <- apply(ms$r, 2, quantile, probs=c(0.025, 0.25, 0.50, 0.75, 0.975))
d_est <- data.frame(X=d$Y, t(qua), check.names=FALSE)
d_all <- data.frame(d_name, d_est, check.names=FALSE) %>% 
  mutate(diff = X - `50%`)
top3_diff <- which(rank(-abs(d_all$diff)) %in% 1:3)

p <- ggplot(data=d_est, aes(x=X, y=`50%`, ymin=`2.5%`, ymax=`97.5%`)) +
  theme_bw(base_size=18) +
  coord_fixed(ratio=1, xlim=c(9, 24), ylim=c(9, 24)) +
  geom_pointrange(color='grey5', fill='grey95', shape=21, size=0.8) +
  geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='dashed') +
  geom_label_repel(
    data=d_all[top3_diff, ], aes(label=name),
    box.padding=grid::unit(2, 'lines'),
    nudge_x=case_when(d_all[top3_diff, ]$name == '東京都' ~ 3, 
                      d_all[top3_diff, ]$name == '長野県' ~ -3,
                      d_all[top3_diff, ]$name == '静岡県' ~ 3),
    nudge_y=case_when(d_all[top3_diff, ]$name == '東京都' ~ -3, 
                      d_all[top3_diff, ]$name == '長野県' ~ 3,
                      d_all[top3_diff, ]$name == '静岡県' ~ 0)) +
  labs(x='Observed', y='Predicted') +
  scale_x_continuous(breaks=seq(0, 25, 5)) +
  scale_y_continuous(breaks=seq(0, 25, 5))
ggsave(p, file='output/fig12-11-left.png', dpi=300, w=4, h=4)


N_mcmc <- length(ms$lp__)
noise_mcmc <- t(replicate(N_mcmc, d$Y)) - ms$r

d_mode <- apply(noise_mcmc, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
}) %>% 
  t() %>% 
  data.frame() %>% 
  magrittr::set_colnames(c('X', 'Y'))

s_dens <- density(ms$s_Y)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 0.2
p <- ggplot(data=d_mode, aes(x=X)) +
  theme_bw(base_size=18) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(aes(y=after_stat(count)*bw), alpha=0.5, color='black', fill='gray20') +
  stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed') +
  geom_rug(sides='b') +
  labs(x='value', y='count') +
  xlim(range(density(d_mode$X)$x))
ggsave(p, file='output/fig12-11-right.png', dpi=300, w=4, h=4)
