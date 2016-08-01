library(ggplot2)
source('../common.R')

load('output/result-model7-2.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=10^ms$y_new, probs=c(0.1, 0.25, 0.5, 0.75, 0.9))
p <- ggplot.5quantile(data=d_est)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=2)
p <- p + labs(x='Area', y='Y')
p <- p + coord_cartesian(xlim=c(11, 118), ylim=c(-50, 1900))
ggsave(file='output/fig7-2-right.png', plot=p, dpi=300, w=4, h=3)
