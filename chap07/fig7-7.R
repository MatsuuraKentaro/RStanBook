library(ggplot2)

p <- ggplot(data=data.frame(X=c(0,5)), aes(x=X)) +
  theme_bw(base_size=18) + theme(legend.key.width=grid::unit(3,'line')) +
  stat_function(fun=function(x) 2*exp(-1*x), aes(linetype='1'), linewidth=1) +
  stat_function(fun=function(x) 1.8/(1+50*exp(-2*x)), aes(linetype='2'), linewidth=1) +
  stat_function(fun=function(x) 8*(exp(-x) - exp(-2*x)), aes(linetype='3'), linewidth=1) +
  scale_linetype_manual(values=c('solid', '52', '12')) +
  labs(linetype='Model', x='Time', y='y')
ggsave(file='output/fig7-7.png', plot=p, dpi=300, w=5, h=3)
