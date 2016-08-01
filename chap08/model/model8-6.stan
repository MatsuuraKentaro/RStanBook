data {
  int N;
  int G;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
  int<lower=1, upper=G> K2G[K];
  int<lower=1, upper=G> GID[N];
}

parameters {
  real a0;
  real b0;
  real a1[G];
  real b1[G];
  real a[K];
  real b[K];
  real<lower=0> s_ag;
  real<lower=0> s_bg;
  real<lower=0> s_a[G];
  real<lower=0> s_b[G];
  real<lower=0> s_Y[G];
}

model {
  for (g in 1:G) {
    a1[g] ~ normal(a0, s_ag);
    b1[g] ~ normal(b0, s_bg);
  }

  for (k in 1:K) {
    a[k] ~ normal(a1[K2G[k]], s_a[K2G[k]]);
    b[k] ~ normal(b1[K2G[k]], s_b[K2G[k]]);
  }

  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y[GID[n]]);
}
