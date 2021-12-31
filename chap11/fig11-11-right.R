library(ggplot2)

load('output/result-model11-8.RData')
ms <- rstan::extract(fit_vb)

probs <- c(0.1, 0.25, 0.5, 0.75, 0.9)
idx <- expand.grid(person=1:N, tag=1:K)

qua <- apply(idx, 1, function(x) quantile(ms$theta[,x[1],x[2]], probs=probs))
d_est <- data.frame(idx, t(qua), check.names=FALSE)

p <- ggplot(data=subset(d_est, person %in% c(1,50)), aes(x=tag, y=`50%`)) +
  theme_bw(base_size=18) +
  facet_wrap(~person, nrow=2) +
  coord_flip() +
  scale_x_reverse(breaks=1:6) +
  geom_bar(stat='identity') +
  geom_errorbar(aes(ymin=`25%`, ymax=`75%`), width=0.25) +
  labs(x='tag', y='theta[n,k]')
ggsave(file='output/fig11-11-right.png', plot=p, dpi=300, w=5, h=5)
