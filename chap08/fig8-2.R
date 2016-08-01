library(ggplot2)

source('sim-model8-3.R')

d$KID <- as.factor(d$KID)
p <- ggplot(d, aes(X, Y_sim, shape=KID))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~KID)
p <- p + geom_line(stat='smooth', method='lm', se=FALSE, size=1, color='black', linetype='31', alpha=0.8)
p <- p + geom_point(size=3)
p <- p + scale_shape_manual(values=c(16, 2, 4, 9))
p <- p + labs(x='X', y='Y')
ggsave(p, file='output/fig8-2.png', dpi=300, w=6, h=5)
