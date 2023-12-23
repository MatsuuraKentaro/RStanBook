library(ggplot2)

load('output/result-model7-4.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$y_new, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est <- data.frame(X=Time_new, t(qua), check.names=FALSE)

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=0.5) +
  geom_point(data=d, aes(x=Time, y=Y), size=3) +
  labs(x='Time (hour)', y='Y') +
  scale_x_continuous(breaks=d$Time, limit=c(0, 24)) +
  ylim(-2.5, 16)
ggsave(file='output/fig7-6-right.png', plot=p, dpi=300, w=4, h=3)
