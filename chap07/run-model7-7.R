library(rstan)

d <- read.csv(file='input/data-protein.txt', stringsAsFactors=FALSE)
idx <- grep('<', d$Y)
Y_obs <- as.numeric(d[-idx, ])
L <- as.numeric(sub('<', '', d[idx,]))[1]

data <- list(N_obs=length(Y_obs), N_cens=length(idx), Y_obs=Y_obs, L=L)
fit <- stan(file='model/model7-7.stan', data=data, seed=1234)
