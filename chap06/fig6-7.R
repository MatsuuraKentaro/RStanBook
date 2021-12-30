library(ggplot2)

d_para <- data.frame(b=c(1, 3), gr=letters[1:2])
my_labs <- parse(text=sprintf('beta=="%.0f"', d_para$b))

p <- ggplot(data.frame(X=c(0, 5)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(b, co) stat_function(fun=dexp, args=list(rate=b), aes_q(linetype=co)),
    d_para$b, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '12'), labels=my_labs) +
  labs(x='y', y='density')
ggsave(file='output/fig6-7.png', plot=p, dpi=300, w=5, h=3)
