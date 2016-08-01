library(ggplot2)

load('output/result-model9-6.RData')
ms <- rstan::extract(fit)

d_est <- data.frame()
for (n in 1:N) {
  qua <- t(apply(ms$mu[,n,], 2, quantile, prob = c(0.025, 0.5, 0.975)))
  d_est <- rbind(d_est, data.frame(PersonID=n, Time=Time, qua))
}
colnames(d_est) <- c('PersonID', 'Time', 'p2.5', 'p50', 'p97.5')

d$Time <- Time[d$TimeID]

p <- ggplot(data=subset(d_est, PersonID %in% c(1,2,3,16)), aes(x=Time, y=p50))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~PersonID)
p <- p + geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/5)
p <- p + geom_line(size=0.5)
p <- p + geom_point(data=subset(d, PersonID %in% c(1,2,3,16)), aes(x=Time, y=Y), size=3)
p <- p + labs(x='Time (hour)', y='Y')
p <- p + scale_x_continuous(breaks=Time, limit=c(0,24))
ggsave(file='output/fig9-2.png', plot=p, dpi=300, w=6, h=5)
