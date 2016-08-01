data {
  int N;
  real Weight[N];
  real Age[N];
  real Y[N];
}

parameters {
  real c[2];
  real b[3];
  real<lower=0> s_W;
  real<lower=0> s_Y;
}

transformed parameters {
  real mu_W[N];
  real mu_Y[N];
  for (n in 1:N){
    mu_W[n] = c[1] + c[2]*Age[n];
    mu_Y[n] = b[1] + b[2]*Age[n] + b[3]*Weight[n];
  }
}

model {
  for (n in 1:N) {
    Weight[n] ~ normal(mu_W[n], s_W);
    Y[n] ~ normal(mu_Y[n], s_Y);
  }
}
