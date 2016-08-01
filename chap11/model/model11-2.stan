data {
  int N;
  int M_max;
  int<lower=0> Y[N];
}

parameters {
  real<lower=0> lambda;
}

model {
  for (n in 1:N) {
    vector[M_max-Y[n]+1] lp;
    for (m in Y[n]:M_max)
      lp[m-Y[n]+1] = poisson_lpmf(m | lambda) + binomial_lpmf(Y[n] | m, 0.5);
    target += log_sum_exp(lp);
  }
}
