library(ggplot2)
source('../common.R')

load('output/result-model8-8.RData')
ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

param_names <- c('mcmc', paste0('b', 1:4), 's_P', 's_C')
d_est <- data.frame(1:N_mcmc, ms$b, ms$s_P, ms$s_C)
colnames(d_est) <- param_names
d_qua <- data.frame.quantile.mcmc(x=param_names[-1], y_mcmc=d_est[,-1])
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')
d_melt$X <- factor(d_melt$X, levels=rev(levels(d_melt$X)))

p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + coord_flip()
p <- p + geom_violin(data=d_melt, aes(x=X, y=value), fill='white', color='grey80', size=2, alpha=0.3, scale='width')
p <- p + geom_pointrange(data=d_qua, aes(x=X, y=p50, ymin=p2.5, ymax=p97.5), size=1)
p <- p + labs(x='parameter', y='value')
p <- p + scale_y_continuous(breaks=seq(from=-2, to=6, by=2))
ggsave(file='output/fig8-9-left.png', plot=p, dpi=300, w=4, h=4)


d_est <- data.frame(1:N_mcmc, ms$b_C)
colnames(d_est) <- c('mcmc', paste0('b_C', 1:10))
d_mode <- data.frame(t(apply(ms$b_C, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
})))
colnames(d_mode) <- c('X', 'Y')
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')

p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + geom_density(data=d_melt, aes(x=value, group=X), fill='black', color='black', alpha=0.15)
p <- p + geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.6)
p <- p + geom_rug(data=d_mode, aes(x=X), sides='b')
p <- p + labs(x='value', y='density')
p <- p + scale_x_continuous(breaks=seq(from=-4, to=4, by=2))
ggsave(file='output/fig8-9-right.png', plot=p, dpi=300, w=4, h=4)
