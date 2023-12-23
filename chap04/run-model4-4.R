library(rstan)
library(ggplot2)

d <- read.csv(file='input/data-salary.txt')
X_new <- 23:60
data <- list(N=nrow(d), X=d$X, Y=d$Y, N_new=length(X_new), X_new=X_new)
fit <- stan(file='model/model4-4.stan', data=data, seed=1234)
ms <- rstan::extract(fit)

qua <- apply(ms$y_base_new, 2, quantile, probs=c(0.025, 0.25, 0.50, 0.75, 0.975))
d_est <- data.frame(X=X_new, t(qua), check.names = FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=3) +
  coord_cartesian(xlim=c(22, 61), ylim=c(200, 1400)) +
  scale_y_continuous(breaks=seq(from=200, to=1400, by=400)) +
  labs(y='Y')
ggsave(p, file='output/fig4-8-left-2.png', dpi=300, w=4, h=3)


qua <- apply(ms$y_new, 2, quantile, probs=c(0.025, 0.25, 0.50, 0.75, 0.975))
d_est <- data.frame(X=X_new, t(qua), check.names = FALSE)

p <- ggplot() +  
  theme_bw(base_size=18) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/6) +
  geom_ribbon(data=d_est, aes(x=X, ymin=`25%`, ymax=`75%`), fill='black', alpha=2/6) +
  geom_line(data=d_est, aes(x=X, y=`50%`), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=3) +
  coord_cartesian(xlim=c(22, 61), ylim=c(200, 1400)) +
  scale_y_continuous(breaks=seq(from=200, to=1400, by=400)) +
  labs(y='Y')
ggsave(p, file='output/fig4-8-right-2.png', dpi=300, w=4, h=3)
