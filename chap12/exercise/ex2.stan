data {
  int T;
  int T_pred;
  vector[T] Y;
}

parameters {
  vector[T] mu;
  vector[T] season;
  real<lower=0> s_mu;
  real<lower=0> s_season;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[T] y_mean;
  y_mean = mu + season;
}

model {
  mu[2:T] ~ normal(mu[1:T-1], s_mu);
  for(t in 4:T)
    season[t] ~ normal(-sum(season[t-3:t-1]), s_season);
  Y ~ normal(y_mean, s_Y);
}

generated quantities {
  vector[T+T_pred] mu_all;
  vector[T+T_pred] season_all;
  vector[T_pred] y_pred;
  mu_all[1:T] = mu;
  season_all[1:T] = season;
  for (t in 1:T_pred) {
    mu_all[T+t] = normal_rng(mu_all[T+t-1], s_mu);
    season_all[T+t] = normal_rng(-sum(season_all[T+t-3:T+t-1]), s_season);
    y_pred[t] = normal_rng(mu_all[T+t] + season_all[T+t], s_Y);
  }
}
