library(ggplot2)

d <- data.frame(X=0:1, Y=c(0.8, 0.2))

p <- ggplot(data=d, aes(x=X, y=Y)) +
  theme_bw(base_size=18) +
  geom_bar(stat='identity') +
  labs(x='y', y='probability') +
  scale_x_continuous(breaks=seq(0, 1, 1))
ggsave(file='output/fig6-2.png', plot=p, dpi=300, w=4, h=3)
