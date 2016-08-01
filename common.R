library(ggplot2)

my_theme <- function(...) {
  theme_bw(base_size=18) + theme(legend.position='none', ...)
}

my_theme0 <- function(...) {
  my_theme(
    axis.ticks=element_blank(),
    axis.text.x=element_blank(),  axis.text.y=element_blank(),
    axis.title.x=element_blank(), axis.title.y=element_blank(),
    ...
  )
}

data.frame.quantile.mcmc <- function(x, y_mcmc, probs=c(2.5, 25, 50, 75, 97.5)/100) {
  qua <- apply(y_mcmc, 2, quantile, probs=probs)
  d <- data.frame(X=x, t(qua))
  colnames(d) <- c('X', paste0('p', probs*100))
  return(d)
}

ggplot.5quantile <- function(data, size=1) {
  qn <- colnames(data)[-1]
  p <- ggplot(data=data, aes(x=X, y=p50))
  p <- p + my_theme()
  p <- p + geom_ribbon(aes_string(ymin=qn[1], ymax=qn[5]), fill='black', alpha=1/6)
  p <- p + geom_ribbon(aes_string(ymin=qn[2], ymax=qn[4]), fill='black', alpha=2/6)
  p <- p + geom_line(size=size)
  return(p)
}

ggplot.obspred <- function(data, xylim, size=0.5) {
  qn <- colnames(data)[-1]
  p <- ggplot(data=data, aes(x=X, y=p50))
  p <- p + my_theme()
  p <- p + coord_fixed(ratio=1, xlim=xylim, ylim=xylim)
  p <- p + geom_pointrange(aes_string(ymin=qn[1], ymax=qn[length(qn)]), color='grey5', fill='grey95', shape=21, size=size)
  p <- p + geom_abline(aes(slope=1, intercept=0), color='black', alpha=3/5, linetype='dashed')
  return(p)
}
