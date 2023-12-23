library(dplyr)
library(ggplot2)

load('output/result-model8-7.RData')
ms <- rstan::extract(fit)
d_est <- data.frame()
for (n in 1:nrow(d)) {
  qua <- apply(ms$y_new[,n,], 2, quantile, prob = c(0.025, 0.5, 0.975))
  d_est <- rbind(d_est, data.frame(PersonID=n, Time=Time_new, t(qua), check.names=FALSE))
}

d <- read.csv(file='input/data-conc-2.txt') %>% 
  tidyr::pivot_longer(cols=-PersonID, values_to='Y') %>% 
  mutate(Time=readr::parse_number(name)) %>% 
  select(-name)

p <- ggplot(data=d_est, aes(x=Time, y=`50%`)) +
  theme_bw(base_size=18) +
  facet_wrap(~PersonID) +
  geom_ribbon(aes(ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/5) +
  geom_line(linewidth=0.5) +
  geom_point(data=d, aes(x=Time, y=Y), size=3) +
  labs(x='Time (hour)', y='Y') +
  scale_x_continuous(breaks=Time, limit=c(0,24)) +
  scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))
ggsave(file='output/fig8-8.png', plot=p, dpi=300, w=8, h=7)
