library(ggplot2)

d <- read.csv(file='input/data-changepoint.txt')
p <- ggplot() +
  theme_bw(base_size=18) +
  geom_line(data=d, aes(x=X, y=Y), linewidth=0.3) +
  labs(x='Time (Second)', y='Y')
ggsave(p, file='output/fig12-5-left.png', dpi=300, w=4, h=3)
