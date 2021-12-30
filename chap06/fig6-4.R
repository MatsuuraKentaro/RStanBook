library(ggplot2)

d_para <- data.frame(a=c(1, 3, 3), b=c(1, 2, 9), gr=letters[1:3])
my_labs <- parse(text=sprintf('alpha=="%.0f"~~beta=="%.0f"', d_para$a, d_para$b))

p <- ggplot(data.frame(X=c(0, 1)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(a, b, co) stat_function(fun=dbeta, args=list(shape1=a, shape2=b), aes_q(linetype=co)),
    d_para$a, d_para$b, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs) +
  labs(x=parse(text='theta'), y='density')
ggsave(file='output/fig6-4-left.png', plot=p, dpi=300, w=4, h=4)


d_para <- data.frame(a=c(0.5, 0.5, 3), b=c(0.5, 1, 1), gr=letters[1:3])
my_labs <- parse(text=sprintf('alpha=="%.1f"~~beta=="%.1f"', d_para$a, d_para$b))

p <- ggplot(data.frame(X=c(0, 1)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.position='bottom', legend.direction ='vertical', legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(a, b, co) stat_function(fun=dbeta, args=list(shape1=a, shape2=b), aes_q(linetype=co)),
    d_para$a, d_para$b, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs) +
  labs(x=parse(text='theta'), y='density')
ggsave(file='output/fig6-4-right.png', plot=p, dpi=300, w=4, h=4)
