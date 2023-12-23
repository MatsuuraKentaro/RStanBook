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
d_est <- data.frame(X, q_qua, check.names=FALSE)
d$A <- as.factor(d$A)

p <- ggplot(d_est, aes(x=X, y=`50%`)) +
  theme_bw(base_size=18) +
  geom_ribbon(aes(ymin=`10%`, ymax=`90%`), fill='black', alpha=2/6) +
  geom_line(linewidth=1) +
  geom_point(data=subset(d, A==0 & Weather=='A'), aes(x=Score, y=Y, color=A),
             position=position_jitter(w=0, h=0.25), size=0.5) +
  labs(x='Score', y='q') +
  scale_color_manual(values=c('black')) +
  scale_y_continuous(breaks=seq(0, 1, 0.2)) +
  xlim(30, 200)
ggsave(file='output/fig5-9.png', plot=p, dpi=300, w=4.5, h=3)
