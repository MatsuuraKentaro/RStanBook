library(ggplot2)

load('output/result-model7-2.RData')
ms <- rstan::extract(fit)

qua <- apply(10^ms$y_new, 2, quantile, probs=c(0.1, 0.25, 0.50, 0.75, 0.9))
d_est <- data.frame(X=X_new, t(qua), check.names=FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`10%`, ymax=`90%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=2) +
  coord_cartesian(xlim=c(11, 118), ylim=c(-50, 1900)) +
  labs(x='Area', y='Y')
ggsave(p, file='output/fig7-2-right.png', dpi=300, w=4, h=3)
