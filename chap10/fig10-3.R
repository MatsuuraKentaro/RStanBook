library(ggplot2)

x <- seq(0, 5, length=101)
p1 <- 2*dt(x, df=4)
p2 <- 2*dnorm(x, mean=0, sd=1)
d <- data.frame(x=x, y1=p1, y2=p2)

p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + geom_line(data=d, aes(x=x, y=y1), size=1)
p <- p + geom_line(data=d, aes(x=x, y=y2), size=1, linetype='31')
p <- p + labs(x='y', y='probability density')
p <- p + ggsave(file='output/fig10-3.png', plot=p, dpi=300, w=4, h=3)

# 2 * (1 - pnorm(4))
# 2 * (1 - pt(4, df=4))
