library(ggplot2)

# after run-model8-2.R

load('../output/result-model8-2.RData')
ms2 <- rstan::extract(fit2)

N_mcmc <- length(ms2$lp__)
X_new <- 0:max(d$X)
N_X <- length(X_new)

d2 <- NULL
for (k in 1:K) {
  y_base_mcmc2 <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
  for (i in 1:N_X) {
    y_base_mcmc2[,i] <- rnorm(N_mcmc, mean=ms2$a[,k] + ms2$b[,k] * X_new[i], sd=ms2$s_Y)
  }
  qua <- apply(y_base_mcmc2, 2, quantile, probs=c(0.025, 0.5, 0.975))
  d2 <- rbind(d2, data.frame(X=X_new, t(qua), KID=k, check.names=FALSE))
}
d$KID <- as.factor(d$KID)
d2$KID <- as.factor(d2$KID)


p <- ggplot(d, aes(x=X, y=Y, shape=KID)) +
  theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5,'line')) +
  facet_wrap(~KID) +
  geom_ribbon(data=d2, aes(y=`50%`, ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/5) +
  geom_line(data=d2, aes(y=`50%`), linewidth=1, alpha=0.8) +
  geom_point(size=3) +
  scale_shape_manual(values=c(16, 2, 4, 9)) +
  labs(x='X', y='Y', shape='KID')
ggsave(p, file='fig-ex1.png', dpi=300, w=6, h=5)
