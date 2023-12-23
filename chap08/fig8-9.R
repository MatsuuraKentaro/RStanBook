library(dplyr)
library(ggplot2)

load('output/result-model8-8.RData')
ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

param_names <- c('mcmc', paste0('b', 1:4), 's_P', 's_C')
d_mcmc <- data.frame(1:N_mcmc, ms$b, ms$s_P, ms$s_C)
colnames(d_mcmc) <- param_names

qua <- apply(d_mcmc[,-1], 2, quantile, probs=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est <- data.frame(X=param_names[-1], t(qua), check.names=FALSE)

d_long <- d_mcmc %>% 
  tidyr::pivot_longer(cols=-mcmc, names_to='X') %>%
  mutate(X = factor(X, levels=rev(param_names[-1])))

p <- ggplot() +
  theme_bw(base_size=18) +
  coord_flip() +
  geom_violin(data=d_long, aes(x=X, y=value), fill='white', color='grey80', linewidth=2, alpha=0.3, scale='width') +
  geom_pointrange(data=d_est, aes(x=X, y=`50%`, ymin=`2.5%`, ymax=`97.5%`), size=1) +
  labs(x='parameter', y='value') +
  scale_y_continuous(breaks=seq(from=-2, to=6, by=2))
ggsave(file='output/fig8-9-left.png', plot=p, dpi=300, w=4, h=4)


d_mcmc <- data.frame(1:N_mcmc, ms$b_C)
colnames(d_mcmc) <- c('mcmc', paste0('b_C', 1:10))
d_mode <- apply(ms$b_C, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
}) %>% 
  t() %>% 
  data.frame() %>% 
  magrittr::set_colnames(c('X', 'Y'))
  
d_long <- d_mcmc %>% tidyr::pivot_longer(cols=-mcmc, names_to='X')

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_density(data=d_long, aes(x=value, group=X), fill='black', color='black', alpha=0.15) +
  geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.6) +
  geom_rug(data=d_mode, aes(x=X), sides='b') +
  labs(x='value', y='density') +
  scale_x_continuous(breaks=seq(from=-4, to=4, by=2))
ggsave(file='output/fig8-9-right.png', plot=p, dpi=300, w=4, h=4)
