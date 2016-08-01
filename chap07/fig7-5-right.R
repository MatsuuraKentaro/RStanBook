library(ggplot2)
source('../common.R')

load('output/result-model7-3.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=ms$y_new)
p <- ggplot.5quantile(data=d_est, size=0.5)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=2)
p <- p + labs(x='X', y='Y')
p <- p + scale_y_continuous(breaks=seq(from=0, to=100, by=50), limits=c(0, 130))
ggsave(file='output/fig7-5-right.png', plot=p, dpi=300, w=4, h=3)
