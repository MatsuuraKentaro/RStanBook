data {
  int N;
  vector<lower=0, upper=1>[N] A;
  vector<lower=0, upper=1>[N] Score;
  vector<lower=0, upper=1>[N] Y;
}

parameters {
  real b1;
  real b2;
  real b3;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu = b1 + b2*A + b3*Score;
}

model {
  Y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] y_pred;
  for (n in 1:N)
    y_pred[n] = normal_rng(mu[n], sigma);
}
