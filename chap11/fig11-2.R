library(ggplot2)

d <- read.csv(file='input/data-mix1.txt')
dens <- density(d$Y)

p <- ggplot(data=d, aes(x=Y)) +
  theme_bw(base_size=18) +
  geom_histogram(binwidth=0.5, colour='black', fill='white') +
  geom_density(aes(y=..count.. * 0.5), alpha=0.35, colour='black', fill='gray20') +
  scale_y_continuous(breaks=seq(from=0, to=10, by=2)) +
  labs(x='Y') + xlim(range(dens$x))
ggsave(file='output/fig11-2.png', plot=p, dpi=300, w=4, h=3)
