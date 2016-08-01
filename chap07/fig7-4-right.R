library(ggplot2)

load('output/result-model7-2.RData')
ms <- rstan::extract(fit)

N_mcmc <- length(ms$lp__)
d_noise <- data.frame(t(-t(ms$mu) + log10(d$Y)))
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

s_dens <- density(ms$s)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 0.02
p <- ggplot(data=d_mode, aes(x=X))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(binwidth=bw, color='black', fill='white')
p <- p + geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.5, color='black', fill='gray20')
p <- p + stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed')
p <- p + labs(x='value', y='count')
p <- p + scale_y_continuous(breaks=seq(from=0, to=12, by=2))
p <- p + scale_x_continuous(breaks=seq(from=-0.25, to=0.25, by=0.25), limits=range(density(d_mode$X)$x))
ggsave(file='output/fig7-4-right.png', plot=p, dpi=300, w=4, h=3)
