library(dplyr)
library(ggplot2)

d <- read.csv(file='input/data-conc-2.txt') %>% 
  tidyr::pivot_longer(cols=-PersonID, values_to='Y') %>% 
  mutate(Time=readr::parse_number(name)) %>% 
  select(-name)

p <- ggplot(data=d, aes(x=Time, y=Y)) +
  theme_bw(base_size=18) +
  facet_wrap(~PersonID) +
  geom_line(linewidth=1) +
  geom_point(size=3) +
  labs(x='Time (hour)', y='Y') +
  scale_x_continuous(breaks=c(0,6,12,24), limit=c(0,24)) +
  scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))
ggsave(file='output/fig8-7-left.png', plot=p, dpi=300, w=8, h=7)
