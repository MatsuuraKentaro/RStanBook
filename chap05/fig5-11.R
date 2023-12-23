library(pROC)
library(ggplot2)

load('output/result-model5-5.RData')
ms <- rstan::extract(fit)

spec <- seq(from=0, to=1, len=201)
N_mcmc <- length(ms$lp__)
N_spec <- length(spec)
probs <- c(0.1, 0.5, 0.9)

auces <- numeric(N_mcmc)
m_roc <- matrix(nrow=N_spec, ncol=N_mcmc)
for (i in 1:N_mcmc) {
  roc_res <- roc(d$Y, ms$q[i,], quiet=TRUE)
  auces[i] <- as.numeric(roc_res$auc)
  m_roc[,i] <- coords(roc_res, x=spec, input='specificity', ret='sensitivity')$sensitivity
}

# quantile(auces, prob=probs)
d_est <- data.frame(X=1-spec, t(apply(m_roc, 1, quantile, prob=probs)), check.names=FALSE)

p <- ggplot(data=d_est, aes(x=X, y=`50%`)) +
  theme_bw(base_size=18) + theme(legend.position='none') +
  coord_fixed(ratio=1, xlim=c(0,1), ylim=c(0,1)) +
  geom_abline(intercept=0, slope=1, alpha=0.5) +
  geom_ribbon(aes(ymin=`10%`, ymax=`90%`), fill='black', alpha=2/6) +
  geom_line(linewidth=1) +
  labs(x='False Positive', y='True Positive')
ggsave(file='output/fig5-11.png', plot=p, dpi=300, w=4, h=4)
