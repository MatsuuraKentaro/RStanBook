library(ggplot2)

ab <- data.frame(a=c(1, 3, 3), b=c(1, 2, 9))
ab <- cbind(ab, gr=letters[1:nrow(ab)])
my_labs <- parse(text=sprintf('alpha=="%.0f"~~beta=="%.0f"', ab$a, ab$b))
p <- ggplot(data.frame(X=c(0, 1)), aes(x=X))
p <- p + theme_bw(base_size=18) + theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line'))
p <- p + mapply(
  function(a, b, co) stat_function(fun=dbeta, args=list(shape1=a, shape2=b), aes_q(linetype=co)),
  ab$a, ab$b, ab$gr
)
p <- p + scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs)
p <- p + labs(x=parse(text='theta'), y='density')
ggsave(file='output/fig6-4-left.png', plot=p, dpi=300, w=4, h=4)


ab <- data.frame(a=c(0.5, 0.5, 3), b=c(0.5, 1, 1))
ab <- cbind(ab, gr=letters[1:nrow(ab)])
my_labs <- parse(text=sprintf('alpha=="%.1f"~~beta=="%.1f"', ab$a, ab$b))
p <- ggplot(data.frame(X=c(0, 1)), aes(x=X))
p <- p + theme_bw(base_size=18) + theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line'))
p <- p + mapply(
  function(a, b, co) stat_function(fun=dbeta, args=list(shape1=a, shape2=b), aes_q(linetype=co)),
  ab$a, ab$b, ab$gr
)
p <- p + scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs)
p <- p + labs(x=parse(text='theta'), y='density')
ggsave(file='output/fig6-4-right.png', plot=p, dpi=300, w=4, h=4)
