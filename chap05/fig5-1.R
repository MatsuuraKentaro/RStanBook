library(ggplot2)
library(GGally)

set.seed(123)
d <- read.csv(file='input/data-attendance-1.txt')
d$A <- as.factor(d$A)

N_col <- ncol(d)
ggp <- ggpairs(d, upper='blank', diag='blank', lower='blank')

for (i in 1:N_col) {
  x <- d[,i]
  p <- ggplot(data.frame(x, A=d$A), aes(x)) +
    theme_bw(base_size=14) +
    theme(axis.text.x=element_text(angle=40, vjust=1, hjust=1))
  if (class(x) == 'factor') {
    p <- p + geom_bar(aes(fill=A), color='grey5')
  } else {
    bw <- (max(x)-min(x))/10
    p <- p + geom_histogram(binwidth=bw, aes(fill=A), color='grey5') +
      geom_line(aes(y=after_stat(count)*bw), stat='density')
  }
  p <- p + geom_label(data=data.frame(x=-Inf, y=Inf, label=colnames(d)[i]), aes(x=x, y=y, label=label), hjust=0, vjust=1) +
    scale_fill_manual(values=alpha(c('white', 'grey40'), 0.5))
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
    p <- ggplot(data.frame(ell), aes(x=x, y=y))
    p <- p + theme_bw() + theme(
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
    p <- ggplot(data.frame(x, y, gr=d$A), aes(x=x, y=y, fill=gr, shape=gr)) +
      theme_bw(base_size=14) +
      theme(axis.text.x=element_text(angle=40, vjust=1, hjust=1))
    if (class(x) == 'factor') {
      p <- p + geom_boxplot(aes(group=x), alpha=3/6, outlier.shape=NA, fill='white') +
        geom_point(position=position_jitter(w=0.4, h=0), size=2)
    } else {
      p <- p + geom_point(size=2)
    }
    p <- p + scale_shape_manual(values=c(21, 24)) +
      scale_fill_manual(values=alpha(c('white', 'grey40'), 0.5))
    ggp <- putPlot(ggp, p, i, j)
  }
}

png(file='output/fig5-1.png', w=1600, h=1600, res=300)
print(ggp, left=0.3, bottom=0.3)
dev.off()
