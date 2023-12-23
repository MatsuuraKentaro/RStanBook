library(ggplot2)

load('output/result-model7-9.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$y_new, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est <- data.frame(X=X_new, t(qua), check.names=FALSE)

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=3) +
  labs(x='X', y='Y') +
  coord_cartesian(xlim=c(-0.2, 11.2), ylim=c(-25, 75))
ggsave(file='output/fig7-12-right.png', plot=p, dpi=300, w=4, h=3)
