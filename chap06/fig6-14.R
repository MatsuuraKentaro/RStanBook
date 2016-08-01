library(ggplot2)

ms <- data.frame(nu=c(1, 4), mu=c(0, 0), sigma=c(1, 1))
ms <- cbind(ms, gr=letters[1:nrow(ms)])
my_labs <- parse(text=c(
	sprintf('nu=="%d"~~mu=="%.0f"~~sigma=="%.0f"', ms$nu, ms$mu, ms$sigma),
	'nu==infinity~~mu==0~~sigma==1')
)
p <- ggplot(data.frame(X=c(-6, 6)), aes(x=X))
p <- p + theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5,'line'))
p <- p + mapply(
  function(nu, co) stat_function(fun=dt, args=list(df=nu), aes_q(linetype=co)),
  ms$nu, ms$gr
)
p <- p + stat_function(fun=dnorm, args=list(mean=0, sd=1), aes_q(linetype='C'))
p <- p + scale_linetype_manual('parameter', values=c('52', 'solid', '12'), labels=my_labs)
p <- p + labs(x='y', y='density')
p <- p + scale_x_continuous(limit=c(-6, 6))
ggsave(file='output/fig6-14.png', plot=p, dpi=300, w=6.5, h=3)


# lapply(c(1,2,3,4,6,8), function(x) pt(1, df=x) - pt(-1, df=x) )
# pnorm(1) - pnorm(-1)
# lapply(c(1,2,3,4,6,8), function(x) 1 - pt(3, df=x) )
# 1 - pnorm(3)
# lapply(c(1,2,3,4,6,8), function(x) 1 - pt(10, df=x) )
# 1 - pnorm(10)
