library(ggplot2)

d_para <- data.frame(mu=c(0, 0), sigma=c(1, 3), gr=letters[1:2])
my_labs <- parse(text=sprintf('mu=="%.0f"~~sigma=="%.0f"', d_para$mu, d_para$sigma))

p <- ggplot(data.frame(X=c(-6, 6)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(mu, sigma, co) stat_function(fun=dcauchy, args=list(location=mu, scale=sigma), aes_q(linetype=co)),
    d_para$mu, d_para$sigma, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '12'), labels=my_labs) +
  labs(x='y', y='density') +
  scale_x_continuous(limit=c(-6, 6)) 
ggsave(file='output/fig6-13.png', plot=p, dpi=300, w=6, h=3)

# pcauchy(1) - pcauchy(-1)
# 1 - pcauchy(10)
