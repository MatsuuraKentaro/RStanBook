library(ggplot2)

d <- read.csv(file='input/data-mix2.txt')
dens <- density(d$Y)

p <- ggplot(data=d, aes(x=Y)) +
  theme_bw(base_size=18) +
  geom_histogram(color='black', fill='white') +
  geom_density(aes(y=after_stat(count)), alpha=0.35, colour='black', fill='gray20') +
  geom_rug(sides='b') +
  labs(x='Y') + xlim(range(dens$x)) 
ggsave(file='output/fig11-3.png', plot=p, dpi=300, w=4, h=3)
