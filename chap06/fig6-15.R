library(ggplot2)
library(bda)

ms <- data.frame(mu=c(0, 0), sigma=c(1, 3))
ms <- cbind(ms, gr=letters[1:nrow(ms)])
my_labs <- parse(text=sprintf('mu=="%.0f"~~sigma=="%.0f"', ms$mu, ms$sigma))
p <- ggplot(data.frame(X=c(-6, 6)), aes(x=X))
p <- p + theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5,'line'))
p <- p + mapply(
  function(mu, sigma, co) stat_function(fun=dlap, args=list(mu=mu, rate=1/sigma), aes_q(linetype=co)),
  ms$mu, ms$sigma, ms$gr
)
p <- p + scale_linetype_manual('parameter', values=c('solid', '12'), labels=my_labs)
p <- p + labs(x='y', y='density')
p <- p + scale_x_continuous(limit=c(-6, 6))
ggsave(file='output/fig6-15.png', plot=p, dpi=300, w=6, h=3)
