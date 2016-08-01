data {
  int N;
  vector[N] X;
  vector[N] Y;
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu = a + b*X;
}

model {
  Y ~ normal(mu, sigma);
}
