library(dplyr)
library(ggplot2)

load('../output/result-model8-5.RData')
ms <- rstan::extract(fit5)
N_mcmc <- length(ms$lp__)

param_names <- c('mcmc', paste0('a1_', 1:3), paste0('b1_', 1:3))
d_mcmc <- data.frame(1:N_mcmc, ms$a1, ms$b1)
colnames(d_mcmc) <- param_names

qua <- apply(d_mcmc[,-1], 2, quantile, probs=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est <- data.frame(X=param_names[-1], t(qua), check.names=FALSE)

d_long <- d_mcmc %>% 
  tidyr::pivot_longer(cols=-mcmc, names_to='X') %>%
  mutate(X = factor(X, levels=rev(param_names[-1])))


p <- ggplot() +
  theme_bw(base_size=18) +
  coord_flip() +
  geom_violin(data=d_long %>% filter(grepl('a1_', X)), aes(x=X, y=value), fill='white', color='grey80', linewidth=2, alpha=0.3, scale='width') +
  geom_pointrange(data=d_est %>% filter(grepl('a1_', X)), aes(x=X, y=`50%`, ymin=`2.5%`, ymax=`97.5%`), size=1) +
  labs(x='parameter', y='value')
ggsave(file='fig-ex3-a1.png', plot=p, dpi=300, width=4, height=5)

p <- ggplot() +
  theme_bw(base_size=18) +
  coord_flip() +
  geom_violin(data=d_long %>% filter(grepl('b1_', X)), aes(x=X, y=value), fill='white', color='grey80', linewidth=2, alpha=0.3, scale='width') +
  geom_pointrange(data=d_est %>% filter(grepl('b1_', X)), aes(x=X, y=`50%`, ymin=`2.5%`, ymax=`97.5%`), size=1) +
  labs(x='parameter', y='value')
ggsave(file='fig-ex3-b1.png', plot=p, dpi=300, width=4, height=5)
