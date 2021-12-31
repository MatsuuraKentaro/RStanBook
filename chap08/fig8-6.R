library(ggplot2)

d <- read.csv('input/data-salary-3.txt')
KIDGID <- unique(d[,3:4])

N <- nrow(d)
K <- 30
G <- 3
coefs <- as.data.frame(t(sapply(1:K, function(k) {
  d_sub <- subset(d, KID==k)
  coef(lm(Y ~ X, data=d_sub))
})))
colnames(coefs) <- c('a', 'b')
d_plot <- data.frame(coefs, KIDGID)


bw <- diff(range(d_plot$a))/20
p <- ggplot(data=d_plot, aes(x=a)) +
  theme_bw(base_size=18) +
  facet_wrap(~GID, nrow=3) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20') +
  labs(x='a', y='count')
ggsave(file='output/fig8-6-left.png', plot=p, dpi=300, w=4, h=6)


bw <- diff(range(d_plot$b))/20
p <- ggplot(data=d_plot, aes(x=b)) +
  theme_bw(base_size=18) +
  facet_wrap(~GID, nrow=3) +
  geom_histogram(binwidth=bw, color='black', fill='white') +
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20') +
  labs(x='b', y='count')
ggsave(file='output/fig8-6-right.png', plot=p, dpi=300, w=4, h=6)
