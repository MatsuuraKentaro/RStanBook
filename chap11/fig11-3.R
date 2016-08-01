library(ggplot2)

d <- read.csv(file='input/data-mix2.txt')
dens <- density(d$Y)

p <- ggplot(data=d, aes(x=Y))
p <- p + theme_bw(base_size=18)
p <- p + geom_histogram(color='black', fill='white')
p <- p + geom_density(aes(y=..count..), alpha=0.35, colour='black', fill='gray20')
p <- p + labs(x='Y') + xlim(range(dens$x))
ggsave(file='output/fig11-3.png', plot=p, dpi=300, w=4, h=3)
