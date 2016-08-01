library(ggplot2)

d <- read.csv(file='input/data-rental.txt')

p <- ggplot(data=d, aes(x=Area, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=2)
p <- p + scale_x_continuous(breaks=seq(from=20, to=120, by=20))
ggsave(file = 'output/fig7-1-left.png', plot=p, dpi=300, w=4, h=3)

p <- ggplot(data=d, aes(x=Area, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=2)
p <- p + scale_x_log10(breaks=c(1,2,5,10,20,50,100)) + scale_y_log10(breaks=c(10,20,50,100,200,500,1000,2000))
p <- p + coord_cartesian(xlim=c(9, 120))
ggsave(file = 'output/fig7-1-right.png', plot=p, dpi=300, w=4, h=3)
