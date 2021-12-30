library(ggplot2)

d_para <- data.frame(mu=c(0, 2), sigma=c(1, 0.5), gr=letters[1:2])
my_labs <- parse(text=sprintf('mu=="%.0f"~~sigma=="%.1f"', d_para$mu, d_para$sigma))

p <- ggplot(data.frame(X=c(-4, 4)), aes(x=X)) +
  theme_bw(base_size=18) +
  theme(legend.key.width=grid::unit(2.5,'line')) +
  mapply(
    function(mu, sigma, co) stat_function(fun=dnorm, args=list(mean=mu, sd=sigma), aes_q(linetype=co)),
    d_para$mu, d_para$sigma, d_para$gr
  ) +
  scale_linetype_manual('parameter', values=c('solid', '52', '12'), labels=my_labs) +
  labs(x='y', y='density')
ggsave(file='output/fig6-10.png', plot=p, dpi=300, w=6, h=3)
