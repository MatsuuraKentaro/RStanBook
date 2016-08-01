data {
  int N;
  int<lower=0, upper=1> A[N];
  real<lower=0, upper=1> Score[N];
  int<lower=0> M[N];
}

parameters {
  real b[3];
}

transformed parameters {
  real lambda[N];
  for (n in 1:N)
    lambda[n] = exp(b[1] + b[2]*A[n] + b[3]*Score[n]);
}

model {
  for (n in 1:N)
    M[n] ~ poisson(lambda[n]);
}

generated quantities {
  int m_pred[N];
  for (n in 1:N)
    m_pred[n] = poisson_rng(lambda[n]);
}
