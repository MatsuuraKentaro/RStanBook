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
  y_mean = mu + season;
}

model {
  mu[2:T] ~ normal(mu[1:(T-1)], s_mu);
  for(t in 4:T)
    season[t] ~ normal(-sum(season[(t-3):(t-1)]), s_season);
  Y ~ normal(y_mean, s_Y);
}
