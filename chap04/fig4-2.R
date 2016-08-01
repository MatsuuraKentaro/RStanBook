library(ggplot2)

d <- read.csv(file='input/data-salary.txt')
p <- ggplot(data=d, aes(x=X, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_point(shape=1, size=3)
ggsave(file='output/fig4-2.png', plot=p, dpi=300, w=4, h=3)
