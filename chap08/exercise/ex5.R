library(rstan)

d1 <- read.csv('../input/data-attendance-4-1.txt')
d2 <- read.csv('../input/data-attendance-4-2.txt')
N <- 50
C <- 10
I <- nrow(d2)
d_conv <- data.frame(X=c(0, 0.2, 1))
rownames(d_conv) <- c('A', 'B', 'C')
data <- list(N=N, C=C, I=I, A=d1$A, Score=d1$Score/200,
  PID=d2$PersonID, CID=d2$CourseID, W=d_conv[d2$Weather, ], Y=d2$Y)
fit <- stan(file='ex5.stan', data=data,
  pars=c('b', 'b_P', 'b_C', 's_P', 's_C', 'q'), seed=1234)
