library(rstan)

d <- read.csv('../input/d1.csv')
F2int <- c(C=0, T=1)
pots <- unique(d$pot)
N_Pot <- length(pots)
Pot2int <- 1:N_Pot
names(Pot2int) <- pots

N <- nrow(d)
data <- list(N=N, N_Pot=N_Pot, F=F2int[d$f], N2Pot=Pot2int[d$pot], Y=d$y)
fit <- stan(file='ex7.stan', data=data, seed=1234)
