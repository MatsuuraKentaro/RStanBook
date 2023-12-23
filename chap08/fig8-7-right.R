library(ggplot2)

d <- read.csv(file='input/data-conc-2.txt')
d_last <- d[ncol(d)]

bw <- 3.0
p <- ggplot(data=d_last, aes(x=Time24)) +
  theme_bw(base_size=18) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(aes(y=after_stat(count)*bw), alpha=0.2, color='black', fill='gray20') +
  geom_rug(sides='b') +
  labs(x='Time24', y='count') +
  xlim(range(density(d_last$Time24)$x))
ggsave(file='output/fig8-7-right.png', plot=p, dpi=300, w=4, h=4)
