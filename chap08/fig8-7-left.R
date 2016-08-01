library(ggplot2)

d <- read.csv(file='input/data-conc-2.txt')
Time_tbl <- Time <- c(1, 2, 4, 8, 12, 24)
names(Time_tbl) <- paste0('Time', Time)
d <- reshape2::melt(d, id='PersonID', variable.name='Time', value.name='Y')
d$Time <- Time_tbl[d$Time]

p <- ggplot(data=d, aes(x=Time, y=Y))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~PersonID)
p <- p + geom_line(size=1)
p <- p + geom_point(size=3)
p <- p + labs(x='Time (hour)', y='Y')
p <- p + scale_x_continuous(breaks=Time, limit=c(0,24))
p <- p + scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))
ggsave(file='output/fig8-7-left.png', plot=p, dpi=300, w=8, h=7)
