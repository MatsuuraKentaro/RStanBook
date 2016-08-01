data {
  int N;
  vector<lower=0, upper=1>[N] A;
  vector<lower=0, upper=1>[N] Score;
  int<lower=0> M[N];
}

parameters {
  real b[3];
}

transformed parameters {
  vector[N] lambda;
  lambda = b[1] + b[2]*A + b[3]*Score;
}

model {
  M ~ poisson_log(lambda);
}

generated quantities {
  int m_pred[N];
  for (n in 1:N)
    m_pred[n] = poisson_log_rng(lambda[n]);
}
