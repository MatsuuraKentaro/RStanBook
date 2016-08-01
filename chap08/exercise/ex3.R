library(ggplot2)
source('../../common.R')

load('../output/result-model8-5.RData')
ms <- rstan::extract(fit5)
N_mcmc <- length(ms$lp__)

param_names <- c('mcmc', paste0('a1_', 1:3), paste0('b1_', 1:3))
d_est <- data.frame(1:N_mcmc, ms$a1, ms$b1)
colnames(d_est) <- param_names
d_qua <- data.frame.quantile.mcmc(x=param_names[-1], y_mcmc=d_est[,-1])
d_melt <- reshape2::melt(d_est, id=c('mcmc'), variable.name='X')
d_melt$X <- factor(d_melt$X, levels=rev(levels(d_melt$X)))


p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + coord_flip()
p <- p + geom_violin(data=d_melt[grep('a1_', d_melt$X), ], aes(x=X, y=value), fill='white', color='grey80', size=2, alpha=0.3, scale='width')
p <- p + geom_pointrange(data=d_qua[grep('a1_', d_qua$X), ], aes(x=X, y=p50, ymin=p2.5, ymax=p97.5), size=1)
p <- p + labs(x='parameter', y='value')
ggsave(file='fig-ex3-a1.png', plot=p, dpi=300, width=4, height=5)

p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + coord_flip()
p <- p + geom_violin(data=d_melt[grep('b1_', d_melt$X), ], aes(x=X, y=value), fill='white', color='grey80', size=2, alpha=0.3, scale='width')
p <- p + geom_pointrange(data=d_qua[grep('b1_', d_qua$X), ], aes(x=X, y=p50, ymin=p2.5, ymax=p97.5), size=1)
p <- p + labs(x='parameter', y='value')
ggsave(file='fig-ex3-b1.png', plot=p, dpi=300, width=4, height=5)
