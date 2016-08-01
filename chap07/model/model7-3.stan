data {
  int N;
  real X[N];
  real Y[N];
  int N_new;
  real X_new[N_new];
}

parameters {
  real a;
  real<lower=0> b;
  real<lower=0, upper=30> x0;
  real<lower=0> s_Y;
}

model {
  for (n in 1:N)
    Y[n] ~ normal(a + b*(X[n]-x0)^2, s_Y);
}

generated quantities {
  real y_new[N_new];
  for (n in 1:N_new)
    y_new[n] = normal_rng(a + b*(X_new[n]-x0)^2, s_Y);
}
