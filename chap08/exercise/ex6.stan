data {
  int N;
  int Y[N];
}

parameters {
  real b;
  real b_I[N];
  real<lower=0> s_I;
}

transformed parameters {
  real q[N];
  for (n in 1:N)
    q[n] = inv_logit(b + b_I[n]);
}

model {
  for (n in 1:N)
    b_I[n] ~ normal(0, s_I);

  for (n in 1:N)
    Y[n] ~ binomial(8, q[n]);
}
