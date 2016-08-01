library(ggplot2)
library(GGally)

d <- read.csv(file='input/data-ZIP.txt')
d$Sex <- as.factor(d$Sex)
d$Sake <- as.factor(d$Sake)

N_col <- ncol(d)
ggp <- ggpairs(d, upper='blank', diag='blank', lower='blank')

for(i in 1:N_col) {
  x <- d[,i]
  p <- ggplot(data.frame(x), aes(x=x))
  p <- p + theme_bw(base_size=14)
  p <- p + theme(axis.text.x=element_text(angle=40, vjust=1, hjust=1))
  if (class(x) == 'factor') {
    p <- p + geom_bar(color='grey5', fill='grey80')
  } else {
    bw <- ifelse(colnames(d)[i] == 'Y', 1, (max(x)-min(x))/10)
    p <- p + geom_histogram(binwidth=bw, color='grey5', fill='grey80')
    p <- p + geom_line(eval(bquote(aes(y=..count..*.(bw)))), stat='density')
  }
  p <- p + geom_label(data=data.frame(x=-Inf, y=Inf, label=colnames(d)[i]), aes(x=x, y=y, label=label), hjust=0, vjust=1)
  ggp <- putPlot(ggp, p, i, i)
}

zcolat <- seq(-1, 1, length=81)
zcolre <- c(zcolat[1:40]+1, rev(zcolat[41:81]))

for(i in 1:(N_col-1)) {
  for(j in (i+1):N_col) {
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
      panel.border=element_blank(), axis.ticks=element_blank()
    )
    p <- p + geom_polygon(fill=zcol, color=zcol)
    p <- p + geom_text(data=NULL, x=.5, y=.5, label=100*round(r, 2), size=6, col=textcol)
    ggp <- putPlot(ggp, p, i, j)
  }
}

for(j in 1:(N_col-1)) {
  for(i in (j+1):N_col) {
    x <- d[,j]
    y <- d[,i]
    if (class(x) == 'factor' && class(y) == 'factor') {
      p <- ggplot(reshape2::melt(table(x,y)), aes(x=x, y=y))
      p <- p + theme_bw(base_size=14)
      p <- p + geom_point(aes(size=value), color='grey80')
      p <- p + geom_text(aes(label=value))
      p <- p + scale_size_area(max_size=8)
      p <- p + scale_x_continuous(breaks=0:1, limits=c(-0.5,1.5)) + scale_y_continuous(breaks=0:1, limits=c(-0.5,1.5))
    } else {
      p <- ggplot(data.frame(x, y, Y=d$Y), aes(x=x, y=y, color=Y))
      p <- p + theme_bw(base_size=14)
      p <- p + theme(axis.text.x=element_text(angle=40, vjust=1, hjust=1))
      if (class(x) == 'factor') {
        p <- p + geom_boxplot(aes(group=x), alpha=3/6, outlier.size=0, fill='white')
        p <- p + geom_point(position=position_jitter(w=0.4, h=0), size=1)
      } else {
        p <- p + geom_point(size=1)
      }
      p <- p + scale_color_gradient(low='grey65', high='grey5')
    }
    ggp <- putPlot(ggp, p, i, j)
  }
}

png(file='output/fig11-4.png', w=1600, h=1600, res=300)
print(ggp, left=0.3, bottom=0.3)
dev.off()
