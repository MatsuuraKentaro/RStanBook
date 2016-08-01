data {
  int N;
  int D;
  matrix[N,D] X;
  vector<lower=0, upper=1>[N] Y;
}

parameters {
  vector[D] b;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu = X*b;
}

model {
  Y ~ normal(mu, sigma);
}
