library(ggplot2)

x <- 0:10
d <- data.frame(X=x, Y=dpois(x, lambda=2.5))

p <- ggplot(data=d, aes(x=X, y=Y)) +
  theme_bw(base_size=18) +
  geom_bar(stat='identity') +
  labs(x='y', y='probability') +
  scale_x_continuous(breaks=seq(0, 10, 1))
ggsave(file='output/fig6-8.png', plot=p, dpi=300, w=4, h=3)
