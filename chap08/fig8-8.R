library(ggplot2)

load('output/result-model8-7.RData')
ms <- rstan::extract(fit)
d_est <- data.frame()
for (n in 1:nrow(d)) {
  qua <- t(apply(ms$y_new[,n,], 2, quantile, prob = c(0.025, 0.5, 0.975)))
  d_est <- rbind(d_est, data.frame(PersonID=n, Time=Time_new, qua))
}
colnames(d_est) <- c('PersonID', 'Time', 'p2.5', 'p50', 'p97.5')


Time_tbl <- Time
names(Time_tbl) <- paste0('Time', Time)
d <- reshape2::melt(d, id='PersonID', variable.name='Time', value.name='Y')
d$Time <- Time_tbl[d$Time]


p <- ggplot(data=d_est, aes(x=Time, y=p50))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~PersonID)
p <- p + geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/5)
p <- p + geom_line(size=0.5)
p <- p + geom_point(data=d, aes(x=Time, y=Y), size=3)
p <- p + labs(x='Time (hour)', y='Y')
p <- p + scale_x_continuous(breaks=Time, limit=c(0,24))
p <- p + scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))
ggsave(file='output/fig8-8.png', plot=p, dpi=300, w=8, h=7)
