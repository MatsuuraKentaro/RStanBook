library(ggplot2)

p <- ggplot(data=data.frame(X=c(-6,6)), aes(x=X)) +
  theme_bw(base_size=18) +
  stat_function(fun=function(x) 1/(1+exp(-x))) +
  geom_vline(xintercept=0, linetype='dashed') +
  geom_hline(yintercept=0.5, linetype='dashed') +
  labs(x='x', y='f(x)')
ggsave(file='output/fig5-7.png', plot=p, dpi=300, w=4, h=3)
