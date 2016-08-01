library(ggplot2)

load('output/result-model11-8.RData')
ms <- rstan::extract(fit_vb)

probs <- c(0.1, 0.25, 0.5, 0.75, 0.9)
idx <- expand.grid(1:K, 1:I)

d_qua <- t(apply(idx, 1, function(x) quantile(ms$phi[,x[1],x[2]], probs=probs)))
d_qua <- data.frame(idx, d_qua)
colnames(d_qua) <- c('tag', 'item', paste0('p', probs*100))

p <- ggplot(data=d_qua, aes(x=item, y=p50))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~tag, ncol=3)
p <- p + coord_flip()
p <- p + scale_x_reverse(breaks=c(1, seq(20, 120, 20)))
p <- p + geom_bar(stat='identity')
p <- p + labs(x='ItemID', y='phi[k,y]')
ggsave(file='output/fig11-11-left.png', plot=p, dpi=300, w=7, h=5)
