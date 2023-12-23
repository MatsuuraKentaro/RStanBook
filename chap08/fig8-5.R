library(ggplot2)

d <- read.csv(file='input/data-salary-3.txt')
d$GID <- as.factor(d$GID)
res_lm <- lm(Y ~ X, data=d)
coef <- coef(res_lm)

p <- ggplot(d, aes(X, Y, shape=GID)) +
  theme_bw(base_size=18) +
  geom_abline(intercept=coef[1], slope=coef[2], linewidth=2, alpha=0.3) +
  geom_point(size=2) +
  scale_shape_manual(values=c(16, 2, 4, 9)) +
  labs(x='X', y='Y')
ggsave(p, file='output/fig8-5-left.png', dpi=300, w=4, h=3)

p <- ggplot(d, aes(X, Y, shape=GID)) +
  theme_bw(base_size=20) +
  geom_abline(intercept=coef[1], slope=coef[2], linewidth=2, alpha=0.3) +
  facet_wrap(~GID, ncol=2) +
  geom_line(stat='smooth', method='lm', se=FALSE, linewidth=1, color='black', linetype='31', alpha=0.8) +
  geom_point(size=3, alpha=0.8) +
  scale_shape_manual(values=c(16, 2, 4)) +
  labs(x='X', y='Y')
ggsave(p, file='output/fig8-5-right.png', dpi=300, w=6, h=5)
