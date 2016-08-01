library(ggplot2)

load('output/result-model5-3.RData')
ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)

d_noise <- data.frame(t(-t(ms$mu) + d$Y))
colnames(d_noise) <- paste0('noise', 1:nrow(d))
d_est <- data.frame(mcmc=1:N_mcmc, d_noise)
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')

d_mode <- data.frame(t(apply(d_noise, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
})))
colnames(d_mode) <- c('X', 'Y')

p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + geom_line(data=d_melt, aes(x=value, group=X), stat='density', color='black', alpha=0.4)
p <- p + geom_segment(data=d_mode, aes(x=X, xend=X, y=Y, yend=0), color='black', linetype='dashed', alpha=0.4)
p <- p + geom_rug(data=d_mode, aes(x=X), sides='b')
p <- p + labs(x='value', y='density')
ggsave(file='output/fig5-4-left.png', plot=p, dpi=300, w=4, h=3)


s_dens <- density(ms$s)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 0.01
p <- ggplot(data=d_mode, aes(x=X))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(binwidth=bw, color='black', fill='white')
p <- p + geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.5, color='black', fill='gray20')
p <- p + stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed')
p <- p + labs(x='value', y='count')
p <- p + xlim(range(density(d_mode$X)$x))
ggsave(file='output/fig5-4-right.png', plot=p, dpi=300, w=4, h=3)
