data {
  int N;
  real X[N];
  real Y[N];
}

parameters {
  real a;
  real b;
  real x_true[N];
  real<lower=0> s_Y;
}

model {
  for (n in 1:N) {
    X[n] ~ normal(x_true[n], 2.5);
    Y[n] ~ normal(a + b*x_true[n], s_Y);
  }
}
