library(ggplot2)

# after run-model5-6.R

load('../output/result-model5-6.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$m_pred, 2, quantile, prob=c(0.1, 0.5, 0.9))
d_est <- data.frame(d, t(qua), check.names=FALSE)
d_est$A <- as.factor(d_est$A)

p <- ggplot(data=d_est, aes(x=M, y=`50%`, ymin=`10%`, ymax=`90%`, shape=A, fill=A)) +
  coord_fixed(ratio=1, xlim=c(10, 80), ylim=c(10, 80)) +
  geom_pointrange(size=0.8) +
  geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='31') +
  scale_shape_manual(values=c(21, 24)) +
  labs(x='Observed', y='Predicted')
ggsave(file='fig-ex5.png', plot=p, dpi=300, w=5, h=4)
