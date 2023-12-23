library(ggplot2)

load('output/result-model8-1.RData')
load('output/result-model8-2.RData')
load('output/result-model8-3.RData')
ms1 <- rstan::extract(fit1)
ms2 <- rstan::extract(fit2)
ms3 <- rstan::extract(fit3)

K <- 4
qua <- apply(ms2$a, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est1 <- data.frame(KID=1:K-0.1, Model='8-2', t(qua), check.names=FALSE)
qua <- apply(ms3$a, 2, quantile, prob=c(0.025, 0.25, 0.5, 0.75, 0.975))
d_est2 <- data.frame(KID=1:K+0.1, Model='8-3', t(qua), check.names=FALSE)
d_est <- rbind(d_est1, d_est2)

p <- ggplot(data=d_est, aes(x=KID, y=`50%`, ymin=`2.5%`, ymax=`97.5%`, shape=Model, linetype=Model, fill=Model)) +
  theme_bw(base_size=18) + theme(legend.key.height=grid::unit(2.5,'line')) +
  geom_pointrange(size=0.6) +
  geom_hline(yintercept=median(ms1$a), color='black', alpha=0.3, linetype='solid', linewidth=1.2) +
  scale_shape_manual(values=c(21, 21)) +
  scale_linetype_manual(values=c('31', 'solid')) +
  scale_fill_manual(values=c('white','black')) +
  labs(y='a')
ggsave(file='output/fig8-4-left.png', plot=p, dpi=300, w=4, h=3)
