library(ggplot2)

d <- read.csv('input/data-conc.txt')

p <- ggplot(data=d, aes(x=Time, y=Y)) +
  theme_bw(base_size=18) +
  geom_line(linewidth=1) +
  geom_point(size=3) +
  labs(x='Time (hour)', y='Y') +
  scale_x_continuous(breaks=d$Time, limit=c(0,24)) +
  ylim(-2.5, 16)
ggsave(file='output/fig7-6-left.png', plot=p, dpi=300, w=4, h=3)
