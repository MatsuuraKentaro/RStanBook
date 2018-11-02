library(ggplot2)
library(ggrepel)
source('../common.R')

load('output/result-model12-14.RData')
ms <- rstan::extract(fit)

d_name <- read.csv('input/data-map-JIS.txt', header=FALSE, fileEncoding='UTF-8')
colnames(d_name) <- c('prefID', 'name')

d_est <- data.frame.quantile.mcmc(x=d$Y, y_mcmc=ms$r)
d_all <- data.frame(d_name, d_est)
d_all <- transform(d_all, diff=X-p50)
top3_diff <- which(rank(-abs(d_all$diff)) %in% 1:3)

p <- ggplot.obspred(data=d_est, xylim=c(9, 24), size=0.8)
p <- p + geom_label_repel(
  data=d_all[top3_diff, ], aes(label=name),
  box.padding=grid::unit(2, 'lines'),
  nudge_x=ifelse(d_all[top3_diff, ]$diff > 0, 4, -3),
  nudge_y=ifelse(d_all[top3_diff, ]$diff > 0, -2, 3)
)
p <- p + labs(x='Observed', y='Predicted')
p <- p + scale_x_continuous(breaks=seq(0, 25, 5))
p <- p + scale_y_continuous(breaks=seq(0, 25, 5))
ggsave(file='output/fig12-11-left.png', plot=p, dpi=300, w=4, h=4)


d_noise <- data.frame(t(-t(ms$r) + d$Y))
d_mode <- data.frame(t(apply(d_noise, 2, function(x) {
  dens <- density(x)
  mode_i <- which.max(dens$y)
  mode_x <- dens$x[mode_i]
  mode_y <- dens$y[mode_i]
  c(mode_x, mode_y)
})))
colnames(d_mode) <- c('X', 'Y')
s_dens <- density(ms$s_Y)
s_MAP <- s_dens$x[which.max(s_dens$y)]
bw <- 0.2
p <- ggplot(data=d_mode, aes(x=X))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(binwidth=bw, color='black', fill='white')
p <- p + geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.5, color='black', fill='gray20')
p <- p + stat_function(fun=function(x) nrow(d)*bw*dnorm(x, mean=0, sd=s_MAP), linetype='dashed')
p <- p + labs(x='value', y='count')
p <- p + xlim(range(density(d_mode$X)$x))
ggsave(file='output/fig12-11-right.png', plot=p, dpi=300, w=4, h=4)
