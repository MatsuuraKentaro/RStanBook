set.seed(123)

G <- 30
mu_pf <- c(0, 1.5)
pf <- sapply(mu_pf, function(mu) rnorm(G, mean=mu, sd=1))
d <- data.frame(t(apply(pf, 1, order)))
colnames(d) <- c('Loser', 'Winner')
tbl <- table(d$Winner)
