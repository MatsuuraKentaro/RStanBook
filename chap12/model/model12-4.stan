data {
  int T;
  int T_pred;
  vector[T] Y;
}

parameters {
  vector[T] mu;
  real<lower=0> s_mu;
  real<lower=0> s_Y;
}

model {
  mu[3:T] ~ normal(2*mu[2:(T-1)] - mu[1:(T-2)], s_mu);
  Y ~ normal(mu, s_Y);
}

generated quantities {
  vector[T+T_pred] mu_all;
  vector[T_pred] y_pred;
  mu_all[1:T] = mu;
  for (t in 1:T_pred) {
    mu_all[T+t] = normal_rng(2*mu_all[T+t-1] - mu_all[T+t-2], s_mu);
    y_pred[t] = normal_rng(mu_all[T+t], s_Y);
  }
}
