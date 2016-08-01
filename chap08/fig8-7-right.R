library(ggplot2)

d <- read.csv(file='input/data-conc-2.txt')
d_last <- d[ncol(d)]

bw <- 3.0
p <- ggplot(data=d_last, aes(x=Time24))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(binwidth=bw, color='black', fill='white')
p <- p + geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20')
p <- p + labs(x='Time24', y='count')
p <- p + xlim(range(density(d_last$Time24)$x))
ggsave(file='output/fig8-7-right.png', plot=p, dpi=300, w=4, h=4)