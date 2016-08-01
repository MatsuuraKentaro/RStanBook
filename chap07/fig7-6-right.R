library(ggplot2)
source('../common.R')

load('output/result-model7-4.RData')
ms <- rstan::extract(fit)

d_est <- data.frame.quantile.mcmc(x=Time_new, y_mcmc=ms$y_new)
p <- ggplot.5quantile(data=d_est, size=0.5)
p <- p + geom_point(data=d, aes(x=Time, y=Y), shape=16, size=3)
p <- p + labs(x='Time (hour)', y='Y')
p <- p + scale_x_continuous(breaks=d$Time, limit=c(0, 24))
p <- p + ylim(-2.5, 16)
ggsave(file='output/fig7-6-right.png', plot=p, dpi=300, w=4, h=3)
