library(ggplot2)

load('output/result-model12-13.RData')
ms <- rstan::extract(fit)

r_median <- apply(ms$r, c(2,3), median)
png('output/fig12-9-left.png', pointsize=72, width=2400, height=2100)
persp(1:I, 1:J, r_median, theta=55, phi=40, expand=0.5, border='black', col='grey95',
  xlab='Plate Row', ylab='Plate Column', zlab='r', ticktype='detailed', lwd=2)
dev.off()

TID <- as.matrix(TID)
mean_Y <- sapply(1:T, function(t) mean(d[TID==t]) - mean(d))

qua <- apply(ms$beta, 2, quantile, probs=c(0.025, 0.25, 0.50, 0.75, 0.975))
d_est <- data.frame(X=mean_Y, t(qua), check.names=FALSE)

p <- ggplot(data=d_est, aes(x=X, y=`50%`, ymin=`2.5%`, ymax=`97.5%`)) +
  theme_bw(base_size=18) +
  coord_fixed(ratio=1, xlim=c(-5, 5), ylim=c(-5, 5)) +
  geom_pointrange(color='grey5', fill='grey95', shape=21, size=0.8) +
  geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='dashed') +
  labs(x='Mean of Y[TID]', y='beta[t]')
ggsave(p, file='output/fig12-9-right.png', dpi=300, w=4.534, h=4.534)
