library(ggplot2)

set.seed(123)
N <- 200
a <- 0.3
d1 <- rnorm(N, mean=0, sd=2)
d2 <- rnorm(N, mean=-4, sd=1)
d3 <- (runif(N) <= a)
Y <- d1*d3 + d2*(1-d3)
# dens <- density(Y)
# plot(dens$x, dens$y)
d <- data.frame(Y)

comp1 <- function(x) a*nrow(d)*bw*dnorm(x, mean=0, sd=2)
comp2 <- function(x) (1-a)*nrow(d)*bw*dnorm(x, mean=-4, sd=1)
comp_sum <- function(x) a*nrow(d)*bw*dnorm(x, mean=0, sd=2) + (1-a)*nrow(d)*bw*dnorm(x, mean=-4, sd=1)
dens <- density(d$Y)
bw <- diff(range(d$Y))/20
p <- ggplot(data=d, aes(x=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(binwidth=bw, colour='black', fill='white')
p <- p + stat_function(fun=comp1, linetype='dashed')
p <- p + stat_function(fun=comp2, linetype='dashed')
p <- p + stat_function(fun=comp_sum, linetype='solid', size=2, alpha=0.4)
p <- p + labs(x='Y', y='density')
p <- p + ggsave(file='output/fig10-1.png', plot=p, dpi=300, w=4, h=3)
