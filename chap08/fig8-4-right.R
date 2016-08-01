library(ggplot2)

load('output/result-model8-1.RData')
load('output/result-model8-2.RData')
load('output/result-model8-3.RData')
ms1 <- rstan::extract(fit1)
ms2 <- rstan::extract(fit2)
ms3 <- rstan::extract(fit3)

K <- 4
N_mcmc <- length(ms1$lp__)
dx <- data.frame(t(sapply(split(d, d$KID), function(x) range(x$X))))
colnames(dx) <- c('Xmin', 'Xmax')

X_new <- min(dx):max(dx)
N_X <- length(X_new)
y_base_mcmc1 <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
for (i in 1:N_X) y_base_mcmc1[,i] <- ms1$a + ms1$b * X_new[i]
y_base_med1 <- apply(y_base_mcmc1, 2, median)
d1 <- data.frame(X=rep(X_new, 4), Y=rep(y_base_med1, 4), KID=rep(1:4, each=N_X))
d1 <- transform(d1, Model='8-1')

d2 <- NULL
d3 <- NULL
for (k in 1:K) {
  X_new <- dx$Xmin[k]:dx$Xmax[k]
  N_X <- length(X_new)
  y_base_mcmc2 <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
  y_base_mcmc3 <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
  for (i in 1:N_X) {
    y_base_mcmc2[,i] <- ms2$a[,k] + ms2$b[,k] * X_new[i]
    y_base_mcmc3[,i] <- ms3$a[,k] + ms3$b[,k] * X_new[i]
  }
  d2 <- rbind(d2, data.frame(X=X_new, Y=apply(y_base_mcmc2, 2, median), KID=k, Model='8-2'))
  d3 <- rbind(d3, data.frame(X=X_new, Y=apply(y_base_mcmc3, 2, median), KID=k, Model='8-3'))
}


p <- ggplot(d, aes(X, Y, shape=as.factor(KID)))
p <- p + theme_bw(base_size=20) + theme(legend.key.width=grid::unit(2.5,'line'))
p <- p + facet_wrap(~KID)
p <- p + geom_line(data=d1, aes(alpha=Model, linetype=Model, size=Model))
p <- p + geom_line(data=d2, aes(alpha=Model, linetype=Model, size=Model))
p <- p + geom_line(data=d3, aes(alpha=Model, linetype=Model, size=Model))
p <- p + geom_point(size=3, alpha=0.3)
p <- p + scale_shape_manual(values=c(16, 2, 4, 9))
p <- p + scale_size_manual(values=c(2, 1, 1))
p <- p + scale_linetype_manual(values=c('solid', '31', 'solid'))
p <- p + scale_alpha_manual(values=c(0.2, 0.6, 1))
p <- p + labs(x='X', y='Y', shape='KID')
ggsave(p, file='output/fig8-4-right.png', dpi=300, w=6.3, h=5)
