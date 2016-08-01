library(ggplot2)

d <- read.csv(file='input/data-ss1.txt')
p <- ggplot()
p <- p + theme_bw(base_size=18)
p <- p + geom_line(data=d, aes(x=X, y=Y), size=1)
p <- p + geom_point(data=d, aes(x=X, y=Y), size=3)
p <- p + labs(x='Time (Day)', y='Y')
ggsave(file='output/fig12-1-right.png', plot=p, dpi=300, w=4, h=3)
