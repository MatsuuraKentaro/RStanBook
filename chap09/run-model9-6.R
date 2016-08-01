library(rstan)

d_wide <- read.csv('input/data-conc-2-NA-wide.txt')
N <- nrow(d_wide)
Time <- c(1, 2, 4, 8, 12, 24)
colnames(d_wide) <- c('PersonID', 1:length(Time))
d_long <- reshape2::melt(d_wide, id='PersonID',
  variable.name='TimeID', value.name='Y')
d_long$TimeID <- as.integer(d_long$TimeID)
d <- na.omit(d_long)

data <- list(
  I=nrow(d), N=N, T=length(Time), Time=Time,
  PersonID=d$PersonID, TimeID=d$TimeID, Y=d$Y
)
fit <- stan(file='model/model9-6.stan', data=data, seed=123)

save.image('output/result-model9-6.RData')
# write.table(d, file='input/data-conc-2-NA-long.txt', sep=',', quote=FALSE, row.names=FALSE)
