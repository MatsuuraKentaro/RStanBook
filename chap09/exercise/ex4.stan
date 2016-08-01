data {
  int N;
  int G;
  int K;
  vector[N] X;
  vector[N] Y;
  int<lower=1, upper=K> KID[N];
  int<lower=1, upper=G> K2G[K];
}

parameters {
  real a0;
  real b0;
  vector[G] a1;
  vector[G] b1;
  vector[K] a;
  vector[K] b;
  real<lower=0> s_ag;
  real<lower=0> s_bg;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[N] mu;
  mu = a[KID] + b[KID] .* X;
}

model {
  a1 ~ normal(a0, s_ag);
  b1 ~ normal(b0, s_bg);
  a ~ normal(a1[K2G], s_a);
  b ~ normal(b1[K2G], s_b);
  Y ~ normal(mu, s_Y);
}
