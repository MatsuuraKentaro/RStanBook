library(ggplot2)

load('output/result-model12-11.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$Y_mean, 2, quantile, probs=c(0.1, 0.25, 0.50, 0.75, 0.9))
d_est <- data.frame(X=1:I, t(qua), check.names=FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`10%`, ymax=`90%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=0.5) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=2) +
  labs(x='i', y='Y[i]') +
  ylim(0, 22)
ggsave(p, file='output/fig12-7-left.png', dpi=300, w=4, h=3)
