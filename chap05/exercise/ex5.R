library(ggplot2)

# after run-model5-6.R

load('../output/result-model5-6.RData')
ms <- rstan::extract(fit)

d_qua <- t(apply(ms$m_pred, 2, quantile, prob=c(0.1, 0.5, 0.9)))
colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua <- data.frame(d, d_qua)
d_qua$A <- as.factor(d_qua$A)

p <- ggplot(data=d_qua, aes(x=M, y=p50, ymin=p10, ymax=p90, shape=A, fill=A))
p <- p + coord_fixed(ratio=1, xlim=c(10, 80), ylim=c(10, 80))
p <- p + geom_pointrange(size=0.8)
p <- p + geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='31')
p <- p + scale_shape_manual(values=c(21, 24))
p <- p + labs(x='Observed', y='Predicted')
ggsave(file='fig-ex5.png', plot=p, dpi=300, w=5, h=4)
