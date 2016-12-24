library(ggplot2)
source('../common.R')

load('output/result-model12-12.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=1:I, y_mcmc=ms$Y_mean, probs=c(0.1, 0.25, 0.5, 0.75, 0.9))
p <- ggplot.5quantile(data=d_est, size=0.5)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=2)
p <- p + labs(x='i', y='Y[i]')
p <- p + ylim(0, 22)
ggsave(file='output/fig12-7-right.png', plot=p, dpi=300, w=4, h=3)
