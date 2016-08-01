data {
  int N;
  int<lower=0, upper=1> Y[N];
}

parameters {
  real<lower=0, upper=1> q;
}

model {
  for (n in 1:N)
    target += log_sum_exp(
      log(0.2) + bernoulli_lpmf(Y[n] | q),
      log(0.8) + bernoulli_lpmf(Y[n] | 1)
    );
}
