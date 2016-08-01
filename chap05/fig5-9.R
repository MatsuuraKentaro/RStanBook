library(ggplot2)
set.seed(123)

load('output/result-model5-5.RData')
ms <- rstan::extract(fit)

logistic <- function(x) 1/(1+exp(-x))
X <- 30:200
q_qua <- logistic(t(sapply(1:length(X), function(i) {
  q_mcmc <- ms$b[,1] + ms$b[,3]*X[i]/200
  quantile(q_mcmc, probs=c(0.1, 0.5, 0.9))
})))
d_est <- data.frame(X, q_qua)
colnames(d_est) <- c('X', 'p10', 'p50', 'p90')
d$A <- as.factor(d$A)

p <- ggplot(d_est, aes(x=X, y=p50))
p <- p + theme_bw(base_size=18)
p <- p + geom_ribbon(aes(ymin=p10, ymax=p90), fill='black', alpha=2/6)
p <- p + geom_line(size=1)
p <- p + geom_point(data=subset(d, A==0 & Weather=='A'), aes(x=Score, y=Y, color=A),
  position=position_jitter(w=0, h=0.25), size=1)
p <- p + labs(x='Score', y='q')
p <- p + scale_color_manual(values=c('black'))
p <- p + scale_y_continuous(breaks=seq(0, 1, 0.2))
p <- p + xlim(30, 200)
ggsave(file='output/fig5-9.png', plot=p, dpi=300, w=4.5, h=3)
