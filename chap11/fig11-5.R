library(ggplot2)

N <- 50
I <- 120
d_ori <- read.csv(file='input/data-lda.txt')
d <- subset(data.frame(table(d_ori)), Freq >= 1)
d$PersonID <- as.integer(as.character(d$PersonID))
d$ItemID <- as.integer(as.character(d$ItemID))

p <- ggplot(data=d, aes(x=ItemID, y=PersonID, fill=Freq))
p <- p + theme_bw(base_size=22) + theme(axis.text=element_blank(), axis.ticks=element_blank())
p <- p + geom_point(shape=21, color='white', size=1.5)
p <- p + scale_fill_gradient(breaks=c(1,5,10), low='grey80', high='black')
ggsave(file='output/fig11-5.png', plot=p, dpi=300, w=8, h=6)
