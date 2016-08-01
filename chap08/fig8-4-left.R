library(ggplot2)

load('output/result-model8-1.RData')
load('output/result-model8-2.RData')
load('output/result-model8-3.RData')
ms1 <- rstan::extract(fit1)
ms2 <- rstan::extract(fit2)
ms3 <- rstan::extract(fit3)

K <- 4
qua <- apply(ms2$a, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_qua1 <- data.frame(1:K-0.1, '8-2', t(qua))
colnames(d_qua1) <- c('KID', 'Model', 'p2.5', 'p25', 'p50', 'p75', 'p97.5')

qua <- apply(ms3$a, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_qua2 <- data.frame(1:K+0.1, '8-3', t(qua))
colnames(d_qua2) <- c('KID', 'Model', 'p2.5', 'p25', 'p50', 'p75', 'p97.5')
d_qua <- rbind(d_qua1, d_qua2)

p <- ggplot(data=d_qua, aes(x=KID, y=p50, ymin=p2.5, ymax=p97.5, shape=Model, linetype=Model, fill=Model))
p <- p + theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line'))
p <- p + geom_pointrange(size=0.6)
p <- p + geom_hline(yintercept=median(ms1$a), color='black', alpha=0.3, linetype='solid', size=1.2)
p <- p + scale_shape_manual(values=c(21, 21))
p <- p + scale_linetype_manual(values=c('31', 'solid'))
p <- p + scale_fill_manual(values=c('white','black'))
p <- p + labs(y='a')
ggsave(file='output/fig8-4-left.png', plot=p, dpi=300, w=4, h=3)
