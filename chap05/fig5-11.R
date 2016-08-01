library(pROC)
library(ggplot2)

load('output/result-model5-5.RData')
ms <- rstan::extract(fit)

N_mcmc <- length(ms$lp__)
spec <- seq(from=0, to=1, len=201)
probs <- c(0.1, 0.5, 0.9)

auces <- numeric(N_mcmc)
m_roc <- matrix(nrow=length(spec), ncol=N_mcmc)
for (i in 1:N_mcmc) {
  roc_res <- roc(d$Y, ms$q[i,])
  auces[i] <- as.numeric(roc_res$auc)
  m_roc[,i] <- coords(roc_res, x=spec, input='specificity', ret='sensitivity')
}

# quantile(auces, prob=probs)
d_est <- data.frame(1-spec, t(apply(m_roc, 1, quantile, prob=probs)))
colnames(d_est) <- c('X', paste0('p', probs*100))

p <- ggplot(data=d_est, aes(x=X, y=p50))
p <- p + theme_bw(base_size=18) + theme(legend.position='none')
p <- p + coord_fixed(ratio=1, xlim=c(0,1), ylim=c(0,1))
p <- p + geom_abline(intercept=0, slope=1, alpha=0.5)
p <- p + geom_ribbon(aes(ymin=p10, ymax=p90), fill='black', alpha=2/6)
p <- p + geom_line(size=1)
p <- p + labs(x='False Positive', y='True Positive')
ggsave(file='output/fig5-11.png', plot=p, dpi=300, w=4, h=4)
