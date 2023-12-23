library(dplyr)
library(ggplot2)

load('output/result-model7-1.RData')
ms <- rstan::extract(fit)

N_mcmc <- length(ms$lp__)
noise_mcmc <- t(replicate(N_mcmc, d$Y)) - ms$mu

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

s_dens <- density(ms$s)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 25
p <- ggplot(data=d_mode, aes(x=X)) +
  theme_bw(base_size=18) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(aes(y=after_stat(count)*bw), alpha=0.5, color='black', fill='gray20') +
  geom_rug(sides='b') +
  stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed') +
  labs(x='value', y='count') +
  scale_x_continuous(breaks=seq(from=-400, to=400, by=200), limits=range(density(d_mode$X)$x)) +
  scale_y_continuous(breaks=seq(from=0, to=16, by=2))
ggsave(file='output/fig7-4-left.png', plot=p, dpi=300, w=4, h=3)
