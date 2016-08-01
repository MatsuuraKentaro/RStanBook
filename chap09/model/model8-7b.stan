data {
  int N;
  int T;
  vector[T] Time;
  matrix[N,T] Y;
  int T_new;
  vector[T_new] Time_new;
}

parameters {
  real a0;
  real b0;
  vector[N] log_a;
  vector[N] log_b;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[N] a;
  vector[N] b;
  matrix[N,T] mu;
  a = exp(log_a);
  b = exp(log_b);
  for (t in 1:T)
    for (n in 1:N)
      mu[n,t] = a[n]*(1 - exp(-b[n]*Time[t]));
}

model {
  log_a ~ normal(a0, s_a);
  log_b ~ normal(b0, s_b);
  to_vector(Y) ~ normal(to_vector(mu), s_Y);
}

generated quantities {
  real y_new[N,T_new];
  for (n in 1:N)
    for (t in 1:T_new)
      y_new[n,t] = normal_rng(a[n]*(1 - exp(-b[n]*Time_new[t])), s_Y);
}
