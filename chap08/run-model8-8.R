library(rstan)

d1 <- read.csv('input/data-attendance-4-1.txt')
d2 <- read.csv('input/data-attendance-4-2.txt')
N <- 50
C <- 10
I <- nrow(d2)
conv <- c(0, 0.2, 1)
names(conv) <- c('A', 'B', 'C')
data <- list(N=N, C=C, I=I, A=d1$A, Score=d1$Score/200,
  PID=d2$PersonID, CID=d2$CourseID, W=conv[d2$Weather], Y=d2$Y)
fit <- stan(file='model/model8-8.stan', data=data,
  pars=c('b', 'b_P', 'b_C', 's_P', 's_C', 'q'), seed=1234)

save.image('output/result-model8-8.RData')


library(pROC)

ms <- rstan::extract(fit)
N_mcmc <- length(ms$lp__)
spec <- seq(from=0, to=1, len=201)
probs <- c(0.1, 0.5, 0.9)

auces <- numeric(N_mcmc)
m_roc <- matrix(nrow=length(spec), ncol=N_mcmc)
for (i in 1:N_mcmc) {
  roc_res <- roc(d2$Y, ms$q[i,])
  auces[i] <- as.numeric(roc_res$auc)
  m_roc[,i] <- coords(roc_res, x=spec, input='specificity', ret='sensitivity')
}
quantile(auces, prob=probs)