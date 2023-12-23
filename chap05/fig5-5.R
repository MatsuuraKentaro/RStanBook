library(ggplot2)
library(GGally)
library(hexbin)

load('output/result-model5-3.RData')
ms <- rstan::extract(fit)

d <- data.frame(b1=ms$b1, b2=ms$b2, b3=ms$b3, sigma=ms$sigma, `mu[1]`=ms$mu[,1], `mu[50]`=ms$mu[,50], lp__=ms$lp__, check.names=FALSE)
N_col <- ncol(d)
ggp <- ggpairs(d, upper='blank', diag='blank', lower='blank')

for (i in 1:N_col) {
  x <- d[,i]
  bw <- (max(x)-min(x))/10
  p <- ggplot(data.frame(x), aes(x)) +
    theme_bw(base_size=14) +
    theme(axis.text.x=element_text(angle=60, vjust=1, hjust=1)) +
    geom_histogram(binwidth=bw, fill='white', color='grey5') +
    geom_line(eval(bquote(aes(y=after_stat(count)*.(bw)))), stat='density') +
    geom_label(data=data.frame(x=-Inf, y=Inf, label=colnames(d)[i]), aes(x=x, y=y, label=label), hjust=0, vjust=1)
  ggp <- putPlot(ggp, p, i, i)
}

zcolat <- seq(-1, 1, length=81)
zcolre <- c(zcolat[1:40]+1, rev(zcolat[41:81]))

for (i in 1:(N_col-1)) {
  for (j in (i+1):N_col) {
    x <- as.numeric(d[,i])
    y <- as.numeric(d[,j])
    r <- cor(x, y, method='spearman', use='pairwise.complete.obs')
    zcol <- lattice::level.colors(r, at=zcolat, col.regions=grey(zcolre))
    textcol <- ifelse(abs(r) < 0.4, 'grey20', 'white')
    ell <- ellipse::ellipse(r, level=0.95, type='l', npoints=50, scale=c(.2, .2), centre=c(.5, .5))
    p <- ggplot(data.frame(ell), aes(x=x, y=y)) + theme_bw() + theme(
      plot.background=element_blank(),
      panel.grid.major=element_blank(), panel.grid.minor=element_blank(),
      panel.border=element_blank(), axis.ticks=element_blank()) +
      geom_polygon(fill=zcol, color=zcol) +
      geom_text(data=NULL, x=.5, y=.5, label=100*round(r, 2), size=6, col=textcol)
    ggp <- putPlot(ggp, p, i, j)
  }
}

for (j in 1:(N_col-1)) {
  for (i in (j+1):N_col) {
    x <- d[,j]
    y <- d[,i]
    p <- ggplot(data.frame(x, y), aes(x=x, y=y)) +
      theme_bw(base_size=14) +
      theme(axis.text.x=element_text(angle=60, vjust=1, hjust=1)) +
      geom_hex() +
      scale_fill_gradientn(colours=gray.colors(7, start=0.1, end=0.9))
    ggp <- putPlot(ggp, p, i, j)
  }
}

png(file='output/fig5-5.png', w=2100, h=2100, res=300)
print(ggp, left=0.6, bottom=0.6)
dev.off()
