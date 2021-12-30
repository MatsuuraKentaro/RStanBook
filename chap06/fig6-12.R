library(mvtnorm)
library(ggplot2)
library(patchwork)

x_range <- c(-4,6)
y_range <- c(-4,6)
x_breaks <- seq(-4,8,2)
y_breaks <- seq(-4,8,2)

plot.multinormal <- function(file) {
  p_xy <- ggplot(data=d, aes(x=a, y=b)) +
    theme_bw(base_size=18) +
    geom_point(shape=1) +
    geom_hline(aes(yintercept=bfix), color='black', alpha=3/5, linetype='12') +
    scale_x_continuous(breaks=x_breaks, limit=x_range) +
    scale_y_continuous(breaks=y_breaks, limit=y_range) +
    labs(x='a', y='b')

  p_x <- ggplot(d, aes(x=a, y=b)) +
    theme_bw(base_size=18) +
    theme(axis.title.x = element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    stat_function(fun=dnorm, color='black', linetype='solid', args=list(mean=mu1, sd=s1)) +
    stat_function(fun=dnorm, color='black', linetype='12', args=list(mean=mu1_2, sd=s1_2)) +
    scale_x_continuous(breaks=x_breaks, limit=x_range, labels=NULL) +
    labs(y='density')

  p <- wrap_plots(
    p_x,  
    p_xy, 
    nrow = 2,
    heights = c(0.3, 1)
  )
  ggsave(p, file=file, dpi=250, w=5, h=6)
}

set.seed(123)
N <- 200
mu1 <- 0
mu2 <- 1
s1 <- 1.5
s2 <- 1.5
rho <- 0.4
sig <- matrix(c(s1^2, s1*s2*rho, s1*s2*rho, s2^2), 2, 2)
x <- rmvnorm(N, mean=c(mu1, mu2), sigma=sig)
d <- data.frame(x)
colnames(d) <- c('a', 'b')
bfix <- 4
mu1_2 <- mu1 + rho*s1/s2*(bfix - mu2)
s1_2 <- s1 * sqrt(1-rho^2)
plot.multinormal(file='output/fig6-12-left.png')

set.seed(123)
N <- 200
mu1 <- 1
mu2 <- 3
s1 <- 1.5
s2 <- 0.5
rho <- -0.7
sig <- matrix(c(s1^2, s1*s2*rho, s1*s2*rho, s2^2), 2, 2)
x <- rmvnorm(N, mean=c(mu1, mu2), sigma=sig)
d <- data.frame(x)
colnames(d) <- c('a', 'b')
bfix <- 4
mu1_2 <- mu1 + rho*s1/s2*(bfix - mu2)
s1_2 <- s1 * sqrt(1-rho^2)
plot.multinormal(file='output/fig6-12-right.png')
