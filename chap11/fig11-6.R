library(dplyr)
library(ggplot2)

N <- 50
I <- 120
d <- read.csv(file='input/data-lda.txt')

d_cast <- d %>% group_by(PersonID) %>% summarise(n=n()) %>% ungroup()
p <- ggplot(data=d_cast, aes(x=n)) +
  theme_bw(base_size=18) +
  geom_bar(color='grey5', fill='grey80') +
  scale_x_continuous(breaks=seq(10,40,10), limits=c(10,40)) +
  labs(x='count by PersonID', y='count')
ggsave(file='output/fig11-6-left.png', plot=p, dpi=300, w=4, h=3)

d_cast <- d %>% group_by(ItemID) %>% summarise(n=n()) %>% ungroup()
p <- ggplot(data=d_cast, aes(x=n)) +
  theme_bw(base_size=18) +
  geom_bar(color='grey5', fill='grey80') +
  labs(x='count by ItemID', y='count')
ggsave(file='output/fig11-6-right.png', plot=p, dpi=300, w=4, h=3)
