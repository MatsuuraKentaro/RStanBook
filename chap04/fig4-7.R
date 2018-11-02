library(ggplot2)
source('../common.R')

load('output/result-model4-5.RData')
ms <- rstan::extract(fit)
df_mcmc <- data.frame(a=ms$a, b=ms$b, sigma=ms$sigma)

p_xy <- ggplot(df_mcmc,aes(x=a,y=b)) +
  my_theme() +
  geom_point(alpha=1/4, size=2, shape=1) +
  scale_x_continuous(breaks=seq(-400, 200, 200), limits=c(-420, 210)) +
  scale_y_continuous(breaks=seq(15, 25, 5), limits=c(14.5, 29))

p_x <- ggplot(df_mcmc, aes(x=a)) +
  my_theme0() +
  geom_histogram(aes(y=..density..), colour='black', fill='white') +
  geom_density(alpha=0.3, fill='gray20') +
  scale_x_continuous(breaks=seq(-400, 200, 200), limits=c(-420, 210)) +
  labs(x='', y='')

p_y <- ggplot(df_mcmc, aes(x=b)) +
  my_theme0() +
  coord_flip() +
  geom_histogram(aes(y=..density..), colour='black', fill='white') +
  geom_density(alpha=0.3, fill='gray20') +
  scale_x_continuous(breaks=seq(15, 25, 5), limits=c(14.5, 29)) +
  labs(x='', y='')

p_emp <- ggplot(data.frame(0,0)) + theme_bw() + theme(rect=element_rect(fill='white'), panel.border=element_blank())

g_xy <- ggplotGrob(p_xy)
g_x <- ggplotGrob(p_x)
g_y <- ggplotGrob(p_y)
g_emp <- ggplotGrob(p_emp)

g1 <- cbind(g_x, g_emp, size='first')
g2 <- cbind(g_xy, g_y, size='first')
g <- rbind(g1, g2, size='first')
g$widths[1:3] <- grid::unit.pmax(g1$widths[1:3], g2$widths[1:3])
g$heights[8:13] <- g$widths[6:11] <- rep(unit(0.5,'mm'), 6)
g$heights[7] <- g$widths[14] <- unit(3,'cm')

png(file='output/fig4-7.png', res=300, w=1800, h=1800)
grid::grid.draw(g)
dev.off()
