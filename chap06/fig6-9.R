library(ggplot2)

d_para <- data.frame(a=c(1, 3, 3), b=c(1, 3, 1), gr=letters[1:3])
my_labs <- parse(text=sprintf('alpha==%.0f~~beta==%.0f', d_para$a, d_para$b))

p <- ggplot(data.frame(X=c(0, 6)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(a, b, co) stat_function(fun=dgamma, args=list(shape=a, rate=b), aes(linetype=co)),
    d_para$a, d_para$b, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs) +
  labs(x='y', y='density') +
  scale_x_continuous(limit=c(0, 6)) +
  scale_y_continuous(limit=c(0, 2))
ggsave(file='output/fig6-9-left.png', plot=p, dpi=300, w=4, h=4.5)


d_para <- data.frame(a=c(1.0, 1.0, 0.1), b=c(1.0, 3.0, 0.1), gr=letters[1:3])
my_labs <- parse(text=sprintf('alpha=="%.1f"~~beta=="%.1f"', d_para$a, d_para$b))

p <- ggplot(data.frame(X=c(0, 6)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(a, b, co) stat_function(fun=dgamma, args=list(shape=a, rate=b), aes(linetype=co)),
    d_para$a, d_para$b, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs) +
  labs(x='y', y='density') +
  scale_x_continuous(limit=c(0, 6)) +
  scale_y_continuous(limit=c(0, 3))
ggsave(file='output/fig6-9-right.png', plot=p, dpi=300, w=4, h=4.5)
