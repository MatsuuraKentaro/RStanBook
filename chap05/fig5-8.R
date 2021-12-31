library(ggplot2)

load('output/result-model5-4.RData')
ms <- rstan::extract(fit)

qua <- apply(ms$y_pred, 2, quantile, prob=c(0.1, 0.5, 0.9))
d_est <- data.frame(d, t(qua), check.names=FALSE)
d_est$A <- as.factor(d_est$A)

p <- ggplot(data=d_est, aes(x=Y, y=`50%`, ymin=`10%`, ymax=`90%`, shape=A, fill=A)) +
  theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line')) +
  coord_fixed(ratio=1, xlim=c(5, 70), ylim=c(5, 70)) +
  geom_pointrange(size=0.5, color='grey5') +
  geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='dashed') +
  scale_shape_manual(values=c(21, 24)) +
  scale_fill_manual(values=c('white', 'grey70')) +
  labs(x='Observed', y='Predicted') +
  scale_x_continuous(breaks=seq(from=0, to=70, by=20)) +
  scale_y_continuous(breaks=seq(from=0, to=70, by=20))
ggsave(file='output/fig5-8.png', plot=p, dpi=300, w=5, h=4)
