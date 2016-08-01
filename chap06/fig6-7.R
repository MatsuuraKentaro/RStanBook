library(ggplot2)

b <- c(1, 3)
gr <- letters[1:length(b)]
my_labs <- parse(text=sprintf('beta=="%.0f"', b))
p <- ggplot(data.frame(X=c(0, 5)), aes(x=X))
p <- p + theme_bw(base_size=18) + theme(legend.key.width=grid::unit(2.5,'line'))
p <- p + mapply(
  function(b, co) stat_function(fun=dexp, args=list(rate=b), aes_q(linetype=co)),
  b, gr
)
p <- p + scale_linetype_manual('parameter', values=c('solid', '12'), labels=my_labs)
p <- p + labs(x='y', y='density')
ggsave(file='output/fig6-7.png', plot=p, dpi=300, w=5, h=3)
