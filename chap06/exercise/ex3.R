set.seed(123)

y1 <- rnorm(n=2000, mean=50, sd=20)
y2 <- rnorm(n=2000, mean=20, sd=15)
y <- y1 - y2

library(ggplot2)
p <- ggplot(data.frame(x=y), aes(x))
p <- p + geom_density()
ggsave(file='fig-ex3.png', plot=p, dpi=300, w=4, h=3)