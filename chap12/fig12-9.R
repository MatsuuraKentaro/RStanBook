library(ggplot2)
source('../common.R')

load('output/result-model12-13.RData')
ms <- rstan::extract(fit)

r_median <- apply(ms$r, c(2,3), median)
png('output/fig12-9-left.png', pointsize=72, width=2400, height=2100)
persp(1:I, 1:J, r_median, theta=55, phi=40, expand=0.5, border='black', col='grey95',
  xlab='Plate Row', ylab='Plate Column', zlab='r', ticktype='detailed', lwd=2)
dev.off()

TID <- as.matrix(TID)
mean_Y <- sapply(1:T, function(t) mean(d[TID==t]) - mean(d))

d_est <- data.frame.quantile.mcmc(x=mean_Y, y_mcmc=ms$beta)
p <- ggplot.obspred(data=d_est, xylim=c(-5, 5), size=0.8)
p <- p + labs(x='Mean of Y[TID]', y='beta[t]')
ggsave(file='output/fig12-9-right.png', plot=p, dpi=300, w=4.534, h=4.534)
