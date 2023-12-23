library(ggplot2)

load('output/result-model9-6.RData')
ms <- rstan::extract(fit)

d_est <- data.frame()
for (n in 1:N) {
  qua <- apply(ms$mu[,n,], 2, quantile, prob = c(0.025, 0.5, 0.975))
  d_est <- rbind(d_est, data.frame(PersonID=n, Time=Time, t(qua), check.names=FALSE))
}

d$Time <- Time[d$TimeID]

p <- ggplot(data=subset(d_est, PersonID %in% c(1,2,3,16)), aes(x=Time, y=`50%`)) +
  theme_bw(base_size=18) +
  facet_wrap(~PersonID) +
  geom_ribbon(aes(ymin=`2.5%`, ymax=`97.5%`), fill='black', alpha=1/5) +
  geom_line(linewidth=0.5) +
  geom_point(data=subset(d, PersonID %in% c(1,2,3,16)), aes(x=Time, y=Y), size=3) +
  labs(x='Time (hour)', y='Y') +
  scale_x_continuous(breaks=Time, limit=c(0,24))
ggsave(file='output/fig9-2.png', plot=p, dpi=300, w=6, h=5)
