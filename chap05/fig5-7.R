library(ggplot2)

p <- ggplot(data=data.frame(X=c(-6,6)), aes(x=X))
p <- p + theme_bw(base_size=18)
p <- p + stat_function(fun=function(x) 1/(1+exp(-x)))
p <- p + geom_vline(xintercept=0, linetype='dashed')
p <- p + geom_hline(yintercept=0.5, linetype='dashed')
p <- p + labs(x='x', y='f(x)')
ggsave(file='output/fig5-7.png', plot=p, dpi=300, w=4, h=3)
