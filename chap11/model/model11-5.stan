data {
  int N;
  vector[N] Y;
}

parameters {
  real<lower=0, upper=1> a;
  ordered[2] mu;
  vector<lower=0>[2] sigma;
}

model {
  for (n in 1:N)
    target += log_sum_exp(
      log(a)   + normal_lpdf(Y[n] | mu[1], sigma[1]),
      log1m(a) + normal_lpdf(Y[n] | mu[2], sigma[2])
    );
}
