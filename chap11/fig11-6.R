library(ggplot2)

N <- 50
I <- 120
d <- read.csv(file='input/data-lda.txt')
d_cast <- reshape2::dcast(d, PersonID ~ .)
p <- ggplot(data=d_cast, aes(x=.))
p <- p + theme_bw(base_size=18)
p <- p + geom_bar(color='grey5', fill='grey80')
p <- p + scale_x_continuous(breaks=seq(10,40,10), limits=c(10,40))
p <- p + labs(x='count by PersonID', y='count')
ggsave(file='output/fig11-6-left.png', plot=p, dpi=300, w=4, h=3)

d_cast <- reshape2::dcast(d, ItemID ~ .)
p <- ggplot(data=d_cast, aes(x=.))
p <- p + theme_bw(base_size=18)
p <- p + geom_bar(color='grey5', fill='grey80')
p <- p + labs(x='count by ItemID', y='count')
ggsave(file='output/fig11-6-right.png', plot=p, dpi=300, w=4, h=3)
