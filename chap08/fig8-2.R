library(ggplot2)

source('sim-model8-3.R')

d$KID <- as.factor(d$KID)
p <- ggplot(d, aes(X, Y_sim, shape=KID)) +
  theme_bw(base_size=18) +
  facet_wrap(~KID) +
  geom_line(stat='smooth', method='lm', se=FALSE, linewidth=1, color='black', linetype='31', alpha=0.8) +
  geom_point(size=3) +
  scale_shape_manual(values=c(16, 2, 4, 9)) +
  labs(x='X', y='Y')
ggsave(p, file='output/fig8-2.png', dpi=300, w=6, h=5)
