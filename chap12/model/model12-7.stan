data {
  int T;
  vector[T] Y;
}

parameters {
  real mu0;
  real<lower=0> s_mu;
  vector<lower=-pi()/2, upper=pi()/2>[T-1] mu_raw;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[T] mu;
  mu[1] = mu0;
  for (t in 2:T)
    mu[t] = mu[t-1] + s_mu*tan(mu_raw[t-1]);
}

model {
  Y ~ normal(mu, s_Y);
}
