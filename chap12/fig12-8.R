library(ggplot2)

m <- as.matrix(read.csv('input/data-2Dmesh.txt', header=FALSE))
rownames(m) <- 1:16
colnames(m) <- 1:24
d_melt <- reshape2::melt(m)
colnames(d_melt) <- c('i','j','Y')

p <- ggplot(data=d_melt, aes(x=j, y=i, z=Y, fill=Y))
p <- p + theme_bw(base_size=20)
p <- p + theme(legend.key.size=grid::unit(2.0, 'lines'), panel.background=element_blank())
p <- p + geom_tile(color='black')
p <- p + scale_fill_gradient2(midpoint=median(m), low='black', mid='gray50', high='white')
p <- p + scale_x_continuous(breaks=c(5,10,15,20))
p <- p + scale_y_reverse(breaks=c(5,10,15))
p <- p + xlab('Plate Column') + ylab('Plate Row')
p <- p + coord_cartesian(xlim=c(0.5, 24.5), ylim=c(0.5, 16.5), expand=FALSE)
ggsave(p, file='output/fig12-8.png', dpi=300, w=6.4, h=4)
