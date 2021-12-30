library(ggplot2)

d <- data.frame(X=c(-Inf,-2,1), Xend=c(-2,1,Inf), Y=c(0,1/3,0), Yend=c(0,1/3,0))

p <- ggplot() +
  theme_bw(base_size=18) +
  geom_segment(data=d, aes(x=X, y=Y, xend=Xend, yend=Yend), size=2) +
  geom_point(data=data.frame(X=c(-2,1), Y=c(0,0)), aes(X,Y), size=3, shape=21, fill='white') +
  geom_point(data=data.frame(X=c(-2,1), Y=c(1/3,1/3)), aes(X,Y), size=3, shape=21, fill='black') +
  labs(x='y', y='density') + xlim(-3,3)
ggsave(file='output/fig6-1.png', plot=p, dpi=300, w=4, h=3)
