library(ggplot2)
source('../common.R')

load('output/result-model7-2.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=d$Y, y_mcmc=10^ms$y_pred, probs=c(0.1, 0.25, 0.5, 0.75, 0.9))
p <- ggplot.obspred(data=d_est, xylim=c(-50, 1900))
p <- p + labs(x='Observed', y='Predicted')
ggsave(file='output/fig7-3-right.png', plot=p, dpi=300, w=4.2, h=4)
