library(ggplot2)
library(patchwork)

load('output/result-model4-5.RData')
ms <- rstan::extract(fit)
df_mcmc <- data.frame(a=ms$a, b=ms$b, sigma=ms$sigma)

x_range <- c(-420, 210)
y_range <- c(14.5, 29)
x_breaks <- seq(-400, 200, 200)
y_breaks <- seq(15, 25, 5)

p_xy <- ggplot(df_mcmc, aes(x=a,y=b)) +
  theme_bw(base_size=18) +
  coord_cartesian(xlim = x_range, ylim = y_range) +
  geom_point(alpha=1/4, size=2, shape=1) +
  scale_x_continuous(breaks=x_breaks) +
  scale_y_continuous(breaks=y_breaks)

p_x <- ggplot(df_mcmc, aes(x=a)) +
  theme_bw(base_size=18) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.text.y=element_blank(), axis.ticks.x=element_blank(), axis.ticks.y=element_blank()) +
  coord_cartesian(xlim=x_range) +
  geom_histogram(aes(y=after_stat(density)), colour='black', fill='white') +
  geom_density(alpha=0.3, fill='gray20') +
  scale_x_continuous(breaks=x_breaks) +
  labs(x='', y='')

p_y <- ggplot(df_mcmc, aes(x=b)) +
  theme_bw(base_size=18) +
  theme(axis.title.y=element_blank(), axis.text.x=element_blank(), axis.text.y=element_blank(), axis.ticks.x=element_blank(), axis.ticks.y=element_blank()) +
  coord_flip(xlim=y_range) +
  geom_histogram(aes(y=after_stat(density)), colour='black', fill='white') +
  geom_density(alpha=0.3, fill='gray20') +
  scale_x_continuous(breaks=y_breaks) +
  labs(x='', y='')

p <- wrap_plots(
  p_x, plot_spacer(), 
  p_xy, p_y, 
  nrow = 2,
  widths = c(1, 0.3),
  heights = c(0.3, 1)
)

ggsave(p, file='output/fig4-7.png', dpi=250, w=6, h=6)
