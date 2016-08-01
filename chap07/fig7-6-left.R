library(ggplot2)

d <- read.csv('input/data-conc.txt')

p <- ggplot(data=d, aes(x=Time, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_line(size=1)
p <- p + geom_point(size=3)
p <- p + labs(x='Time (hour)', y='Y')
p <- p + scale_x_continuous(breaks=d$Time, limit=c(0,24))
p <- p + ylim(-2.5, 16)
ggsave(file='output/fig7-6-left.png', plot=p, dpi=300, w=4, h=3)
