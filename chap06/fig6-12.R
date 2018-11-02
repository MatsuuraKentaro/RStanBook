library(ggplot2)
library(mvtnorm)
source('../common.R')

plot.multinormal <- function(file) {
  p_xy <- ggplot(data=d, aes(x=a, y=b)) +
    my_theme() +
    geom_point(shape=1) +
    geom_hline(aes(yintercept=bfix), color='black', alpha=3/5, linetype='12') +
    scale_x_continuous(breaks=seq(-4,8,2), limit=c(-4,6)) +
    scale_y_continuous(breaks=seq(-4,8,2), limit=c(-4,6)) +
    labs(x='a', y='b')

  p_x <- ggplot(d, aes(x=a, y=b)) +
    my_theme0() +
    stat_function(fun=dnorm, color='black', linetype='solid', args=list(mean=mu1, sd=s1)) +
    stat_function(fun=dnorm, color='black', linetype='12', args=list(mean=mu1_2, sd=s1_2)) +
    scale_x_continuous(breaks=seq(-4,8,2), limit=c(-4,6), labels=NULL)

  g_xy <- ggplotGrob(p_xy)
  g_x <- ggplotGrob(p_x)
  g <- rbind(g_x, g_xy, size='first')
  g$widths[1:3] <- grid::unit.pmax(g_xy$widths[1:3], g_x$widths[1:3])
  g$heights[8:13] <- rep(unit(0.3,'mm'), 6)
  g$heights[7] <- unit(2,'cm')

  png(file=file, res=300, w=1200, h=1400)
  grid::grid.draw(g)
  dev.off()
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
