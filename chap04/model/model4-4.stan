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

transformed parameters {
  real y_base[N];
  for (n in 1:N)
    y_base[n] = a + b*X[n];
}

model {
  for (n in 1:N)
    Y[n] ~ normal(y_base[n], sigma);
}

generated quantities {
  real y_base_new[N_new];
  real y_new[N_new];
  for (n in 1:N_new) {
    y_base_new[n] = a + b*X_new[n];
    y_new[n] = normal_rng(y_base_new[n], sigma);
  }
}
