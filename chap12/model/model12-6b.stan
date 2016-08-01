data {
  int T;
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
  vector[T-3] sum_part_season;
  y_mean = mu + season;
  for(t in 4:T)
    sum_part_season[t-3] = sum(season[(t-3):t]);
}

model {
  mu[2:T] ~ normal(mu[1:(T-1)], s_mu);
  sum_part_season ~ normal(0, s_season);
  Y ~ normal(y_mean, s_Y);
}
