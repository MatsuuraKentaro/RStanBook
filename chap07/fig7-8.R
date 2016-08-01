library(ggplot2)

d <- read.csv(file='input/data-50m.txt')
d$Age <- as.factor(d$Age)

p <- ggplot(data=d, aes(x=Weight, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=2)
ggsave(file='output/fig7-8-left.png', plot=p, dpi=300, w=3.8, h=3)

p <- ggplot(data=d, aes(x=Weight, y=Y, shape=Age))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(size=2)
p <- p + scale_shape_manual(values=c(3, 1, 2, 4, 5, 6))
ggsave(file='output/fig7-8-right.png', plot=p, dpi=300, w=4.5, h=3)
