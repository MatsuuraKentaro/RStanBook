library(ggplot2)

d <- read.csv(file='input/data-aircon.txt')
p <- ggplot(data=d, aes(x=X, y=Y)) +
  theme_bw(base_size=18) +
  geom_point(shape=1, size=2) +
  labs(x='X', y='Y') +
  scale_x_continuous(limits=c(-3, 32)) +
  scale_y_continuous(breaks=seq(from=0, to=100, by=50), limits=c(0, 130))
ggsave(file='output/fig7-5-left.png', plot=p, dpi=300, w=4, h=3)
