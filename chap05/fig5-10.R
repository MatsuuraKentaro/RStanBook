library(ggplot2)

load('output/result-model5-5.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$q, 2, quantile, prob=c(0.1, 0.5, 0.9))
d_est <- data.frame(d, t(qua), check.names=FALSE)
d_est$Y <- as.factor(d_est$Y)
d_est$A <- as.factor(d_est$A)

p <- ggplot(data=d_est, aes(x=Y, y=`50%`)) +
  theme_bw(base_size=18) +
  coord_flip() +
  geom_violin(trim=FALSE, linewidth=1, color='grey80') +
  geom_point(aes(color=A), position=position_jitter(w=0.3, h=0), size=0.5) +
  scale_color_manual(values=c('grey5', 'grey50')) +
  labs(x='Y', y='q')
ggsave(file='output/fig5-10.png', plot=p, dpi=300, w=4.5, h=3)
