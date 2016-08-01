data {
  int N;
  int K;
  vector[N] X;
  vector[N] Y;
  int<lower=1, upper=K> KID[N];
}

parameters {
  real a0;
  real b0;
  vector[K] a_raw;
  vector[K] b_raw;
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[K] a;
  vector[K] b;
  a = a0 + s_a*a_raw;
  b = b0 + s_b*b_raw;
}

model {
  a_raw ~ normal(0, 1);
  b_raw ~ normal(0, 1);
  Y ~ normal(a[KID] + b[KID] .* X, s_Y);
}
