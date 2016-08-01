library(ggplot2)

d <- read.csv(file='input/data-mvn.txt')
p <- ggplot(data=d, aes(x=Y1, y=Y2))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=3)
ggsave(file='output/fig9-1.png', plot=p, dpi=300, w=4, h=3)
