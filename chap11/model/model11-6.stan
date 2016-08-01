data {
  int N;
  int K;
  vector[N] Y;
}

parameters {
  simplex[K] a;
  ordered[K] mu;
  vector<lower=0>[K] sigma;
  real<lower=0> s_mu;
}

model {
  mu ~ normal(mean(Y), s_mu);
  sigma ~ gamma(1.5, 1.0);
  for (n in 1:N) {
    vector[K] lp;
    for (k in 1:K)
      lp[k] = log(a[k]) + normal_lpdf(Y[n] | mu[k], sigma[k]);
    target += log_sum_exp(lp);
  }
}
