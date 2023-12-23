library(ggplot2)

load('output/result-model12-7.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$mu, 2, quantile, probs=c(0.025, 0.25, 0.50, 0.75, 0.975))
d_est <- data.frame(X=1:T, t(qua), check.names=FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=0.5) +
  geom_line(data=d_est, aes(x=X, y=`2.5%`), linewidth=0.2) +
  geom_line(data=d_est, aes(x=X, y=`97.5%`), linewidth=0.2) +
  geom_line(data=d_est, aes(x=X, y=`25%`), linewidth=0.2) +
  geom_line(data=d_est, aes(x=X, y=`75%`), linewidth=0.2) +
  geom_line(data=d, aes(x=X, y=Y), linewidth=0.3, alpha=0.4) +
  labs(x='Time (Second)', y='Y')
ggsave(p, file='output/fig12-5-right.png', dpi=300, w=4, h=3)
