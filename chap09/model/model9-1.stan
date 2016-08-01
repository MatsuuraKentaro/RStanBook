data {
  int N;
  real X[N];
  real Y[N];
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

transformed parameters {
  real mu[N];
  for (n in 1:N)
    mu[n] = a + b*X[n];
}

model {
  for (n in 1:N)
    Y[n] ~ normal(mu[n], sigma);
}
