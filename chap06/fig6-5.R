library(ggplot2)

d <- data.frame(X=1:5, Y=c(0.1, 0.2, 0.25, 0.35, 0.1))
p <- ggplot(data=d, aes(x=X, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_bar(stat='identity')
p <- p + labs(x='y', y='probability')
p <- p + scale_x_continuous(breaks=seq(1, 5, 1))
ggsave(file='output/fig6-5.png', plot=p, dpi=300, w=4, h=3)
