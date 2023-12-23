library(dplyr)
library(ggplot2)

load('output/result-model5-3.RData')
ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

noise_mcmc <- t(replicate(N_mcmc, d$Y)) - ms$mu

d_est <- data.frame(noise_mcmc, check.names=FALSE) %>% 
  tidyr::pivot_longer(cols=everything(), names_to='Parameter') %>% 
  mutate(PersonID = readr::parse_number(Parameter))

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

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_line(data=d_est, aes(x=value, group=PersonID), stat='density', color='black', alpha=0.4) +
  geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.4) +
  geom_rug(data=d_mode, aes(x=X), sides='b') +
  labs(x='value', y='density')
ggsave(file='output/fig5-4-left.png', plot=p, dpi=300, w=4, h=3)

s_dens <- density(ms$s)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 0.01
p <- ggplot(data=d_mode, aes(x=X)) +
  theme_bw(base_size=18) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(aes(y=after_stat(count)*bw), alpha=0.5, color='black', fill='gray20') +
  geom_rug(sides='b') +
  stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed') +
  labs(x='value', y='density') +
  xlim(range(density(d_mode$X)$x))
ggsave(file='output/fig5-4-right.png', plot=p, dpi=300, w=4, h=3)
