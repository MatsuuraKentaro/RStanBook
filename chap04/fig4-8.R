library(ggplot2)
source('../common.R')

load('output/result-model4-5.RData')
ms <- rstan::extract(fit)

X_new <- 23:60
N_X <- length(X_new)
N_mcmc <- length(ms$lp__)

set.seed(1234)
y_base_mcmc <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
y_mcmc <- as.data.frame(matrix(nrow=N_mcmc, ncol=N_X))
for (i in 1:N_X) {
  y_base_mcmc[,i] <- ms$a + ms$b * X_new[i]
  y_mcmc[,i] <- rnorm(n=N_mcmc, mean=y_base_mcmc[,i], sd=ms$sigma)
}

customize.ggplot.axis <- function(p) {
  p <- p + labs(x='X', y='Y')
  p <- p + scale_y_continuous(breaks=seq(from=200, to=1400, by=400))
  p <- p + coord_cartesian(xlim=c(22, 61), ylim=c(200, 1400))
  return(p)
}

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=y_base_mcmc)
p <- ggplot.5quantile(data=d_est)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)
p <- customize.ggplot.axis(p)
ggsave(file='output/fig4-8-left.png', plot=p, dpi=300, w=4, h=3)

d_est <- data.frame.quantile.mcmc(x=X_new, y_mcmc=y_mcmc)
p <- ggplot.5quantile(data=d_est)
p <- p + geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)
p <- customize.ggplot.axis(p)
ggsave(file='output/fig4-8-right.png', plot=p, dpi=300, w=4, h=3)
