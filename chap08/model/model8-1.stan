data {
  int N;
  real X[N];
  real Y[N];
}

parameters {
  real a;
  real b;
  real<lower=0> s_Y;
}

model {
  for (n in 1:N)
    Y[n] ~ normal(a + b*X[n], s_Y);
}
