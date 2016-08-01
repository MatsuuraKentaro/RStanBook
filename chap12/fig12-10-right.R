library(Nippon)

load('output/result-model12-14.RData')
la <- rstan::extract(fit)
est <- apply(la$r, 2, mean)
est[est > 19] <- 19
cols <- lattice::level.colors(
  est, at=seq(9, 19, length=81),
  col.regions=colorRampPalette(RColorBrewer::brewer.pal(9,'Greys'))(100)
)
png('output/fig12-10-right.png', w=800, h=600)
JapanPrefecturesMap(col=cols)
dev.off()
