library(ggplot2)

set.seed(123)

SimulateSS <- function(N, T, s_mu, s_Y) {
  d <- NULL
  for (n in 1:N) {
    mu <- numeric(T)
    mu[1] <- 10
    for (t in 2:T)
      mu[t] <- rnorm(n=1, mean=mu[t-1], sd=s_mu)
    Y <- rnorm(n=T, mean=mu, sd=s_Y)
    d <- rbind(d, data.frame(Trial=n, Time=1:T, Y=round(Y, 2)))
  }
  d$Trial <- as.factor(d$Trial)
  return(d)
}

d1 <- SimulateSS(N=5, T=21, s_mu=2, s_Y=0.1)
p <- ggplot(data=d1, aes(x=Time, y=Y, group=Trial, color=Trial))
p <- p + geom_line(size=1.5, alpha=0.5)
ggsave(file='fig-ex1_a.png', plot=p, dpi=300, width=4, height=3)


d2 <- SimulateSS(N=5, T=21, s_mu=0.1, s_Y=2)
p <- ggplot(data=d2, aes(x=Time, y=Y, group=Trial, color=Trial))
p <- p + geom_line(size=1.5, alpha=0.5)
ggsave(file='fig-ex1_b.png', plot=p, dpi=300, width=4, height=3)

