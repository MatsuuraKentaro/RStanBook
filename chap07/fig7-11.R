library(ggplot2)

d <- read.csv(file='input/data-outlier.txt')

p <- ggplot(data=d, aes(x=X, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=3)
p <- p + labs(x='X', y='Y')
p <- p + coord_cartesian(xlim=c(-0.2, 11.2), ylim=c(-25, 75))
ggsave(file='output/fig7-11.png', plot=p, dpi=300, w=4, h=3)
