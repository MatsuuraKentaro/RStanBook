library(ggplot2)
source('../common.R')

load('output/result-model12-6.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=1:T, y_mcmc=ms$mu, probs=c(0.1, 0.25, 0.5, 0.75, 0.9))
p <- ggplot.5quantile(data=d_est, size=0.5)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=16, size=1)
p <- p + geom_line(data=d, aes(x=X, y=Y), size=0.25)
p <- p + labs(x='Time (Quarter)', y='Y')
p <- p + coord_cartesian(xlim=c(1, 44))
ggsave(file='output/fig12-4-left.png', plot=p, dpi=300, w=4, h=3)

d_est <- data.frame.quantile.mcmc(x=1:T, y_mcmc=ms$season, probs=c(0.1, 0.25, 0.5, 0.75, 0.9))
p <- ggplot.5quantile(data=d_est, size=0.5)
p <- p + labs(x='Time (Quarter)', y='Y')
p <- p + coord_cartesian(xlim=c(1, 44))
ggsave(file='output/fig12-4-right.png', plot=p, dpi=300, w=4, h=3)
