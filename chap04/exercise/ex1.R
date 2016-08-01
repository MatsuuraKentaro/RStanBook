library(ggplot2)

source('generate-data.R')

d1 <- data.frame(group=1, Y=Y1)
d2 <- data.frame(group=2, Y=Y2)
d <- rbind(d1, d2)
d$group <- as.factor(d$group)

p <- ggplot(data=d, aes(x=group, y=Y, group=group, col=group))
p <- p + geom_boxplot(outlier.size=0)
p <- p + geom_point(position=position_jitter(w=0.4, h=0), size=2)
ggsave(file='fig-ex1.png', plot=p, dpi=300, w=4, h=3)

