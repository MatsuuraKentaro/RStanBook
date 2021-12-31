library(ggplot2)

load('output/result-model11-8.RData')
ms <- rstan::extract(fit_vb)

probs <- c(0.1, 0.25, 0.5, 0.75, 0.9)
idx <- expand.grid(tag=1:K, item=1:I)

qua <- apply(idx, 1, function(x) quantile(ms$phi[,x[1],x[2]], probs=probs))
d_est <- data.frame(idx, t(qua), check.names=FALSE)

p <- ggplot(data=d_est, aes(x=item, y=`50%`)) +
  theme_bw(base_size=18) +
  theme(axis.text.x=element_text(angle=40, vjust=1, hjust=1)) +
  facet_wrap(~tag, ncol=3) +
  coord_flip() +
  scale_x_reverse(breaks=c(1, seq(20, 120, 20))) +
  geom_bar(stat='identity') +
  labs(x='ItemID', y='phi[k,y]')
ggsave(file='output/fig11-11-left.png', plot=p, dpi=300, w=7, h=5)
