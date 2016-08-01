data {
  int N;
  real X[N];
  real Y[N];
  int N_new;
  real X_new[N_new];
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

model {
  for (n in 1:N)
    Y[n] ~ cauchy(a + b*X[n], sigma);
}

generated quantities {
  real y_new[N_new];
  for (n in 1:N_new)
    y_new[n] = cauchy_rng(a + b*X_new[n], sigma);
}
