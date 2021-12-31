library(ggplot2)

load('output/result-model7-2.RData')
ms <- rstan::extract(fit)

qua <- apply(10^ms$y_pred, 2, quantile, probs=c(0.1, 0.25, 0.50, 0.75, 0.9))
d_est <- data.frame(X=d$Y, t(qua), check.names=FALSE)

p <- ggplot(data=d_est, aes(x=X, y=`50%`)) +
  theme_bw(base_size=18) +
  coord_fixed(ratio=1, xlim=c(-50, 1900), ylim=c(-50, 1900)) +
  geom_pointrange(aes(ymin=`10%`, ymax=`90%`), color='grey5', fill='grey95', shape=21) +
  geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='dashed') +
  labs(x='Observed', y='Predicted')
ggsave(p, file='output/fig7-3-right.png', dpi=300, w=4.2, h=4)
