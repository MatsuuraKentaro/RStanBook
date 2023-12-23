library(ggplot2)

load('output/result-model12-4.RData')
ms <- rstan::extract(fit)
# quantile(ms$s_mu, probs=c(0.1, 0.5, 0.9))
# quantile(ms$s_Y, probs=c(0.1, 0.5, 0.9))

qua <- apply(ms$mu_all, 2, quantile, probs=c(0.1, 0.25, 0.50, 0.75, 0.9))
d_est <- data.frame(X=1:(T+T_pred), t(qua), check.names=FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`10%`, ymax=`90%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), shape=16, size=2.5) +
  geom_vline(xintercept=T, linetype='dashed') +
  coord_cartesian(xlim=c(1, 24), ylim=c(10, 14)) +
  labs(x='Time (Day)', y='Y')
ggsave(p, file='output/fig12-3-right.png', dpi=300, w=4, h=3)
