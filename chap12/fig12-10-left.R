library(Nippon)
library(NipponMap)

d <- read.csv('input/data-map-temperature.txt')
d$Y[d$Y > 19] <- 19
cols <- lattice::level.colors(
  d$Y, at=seq(9, 19, length=81),
  col.regions=colorRampPalette(RColorBrewer::brewer.pal(9,'Greys'))(100)
)
png('output/fig12-10-left.png', w=800, h=600)
JapanPrefMap(col=cols)
dev.off()
