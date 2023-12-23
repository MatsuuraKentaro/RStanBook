library(ggplot2)

d <- read.csv(file='input/data-ss1.txt')
p <- ggplot() +
  theme_bw(base_size=18) +
  geom_line(data=d, aes(x=X, y=Y), linewidth=1) +
  geom_point(data=d, aes(x=X, y=Y), size=3) +
  labs(x='Time (Day)', y='Y')
ggsave(p, file='output/fig12-1-right.png', dpi=300, w=4, h=3)
