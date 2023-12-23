library(MCMCpack)
library(ggplot2)

x <- c(seq(1e-10, 0.0005, length=100), seq(0.0005, 0.005, length=100), seq(0.005, 0.02, length=100), seq(0.02, 0.5, length=100), seq(0.5, 3, length=100), seq(3, 10, length=100))
p1 <- dinvgamma(x, shape=0.001, scale=0.001)
p2 <- dinvgamma(x, shape=0.1, scale=0.1)

d <- data.frame(x=x, y1=p1, y2=p2)

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_line(data=d, aes(x=x, y=y1), color='black', linewidth=1, linetype='31') +
  geom_line(data=d, aes(x=x, y=y2), color='black', linewidth=1) +
  labs(x='y', y='probability density')
ggsave(file='output/fig10-2-left.png', plot=p, dpi=300, w=4, h=3)

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_line(data=d, aes(x=x, y=y1), color='black', linewidth=1, linetype='31') +
  geom_line(data=d, aes(x=x, y=y2), color='black', linewidth=1) +
  labs(x='y', y='probability density') +
  scale_x_continuous(breaks=seq(from=0, to=0.01, by=0.002), limits=c(0, 0.01))
ggsave(file='output/fig10-2-right.png', plot=p, dpi=300, w=4, h=3)
