library(ggplot2)

d <- data.frame(X=x<-0:10, Y=dbinom(x, size=10, prob=0.2))
p <- ggplot(data=d, aes(x=X, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_bar(stat='identity')
p <- p + labs(x='y', y='probability')
p <- p + scale_x_continuous(breaks=seq(0, 10, 1))
ggsave(file='output/fig6-3.png', plot=p, dpi=300, w=4, h=3)
