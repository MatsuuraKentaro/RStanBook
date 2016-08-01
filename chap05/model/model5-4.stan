data {
  int N;
  int<lower=0, upper=1> A[N];
  real<lower=0, upper=1> Score[N];
  int<lower=0> M[N];
  int<lower=0> Y[N];
}

parameters {
  real b1;
  real b2;
  real b3;
}

transformed parameters {
  real q[N];
  for (n in 1:N)
    q[n] = inv_logit(b1 + b2*A[n] + b3*Score[n]);
}

model {
  for (n in 1:N)
    Y[n] ~ binomial(M[n], q[n]);
}

generated quantities {
  real y_pred[N];
  for (n in 1:N)
    y_pred[n] = binomial_rng(M[n], q[n]);
}
