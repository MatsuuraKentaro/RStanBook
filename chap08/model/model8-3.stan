data {
  int N;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
}

parameters {
  real a0;
  real b0;
  real ak[K];
  real bk[K];
  real<lower=0> s_a;
  real<lower=0> s_b;
  real<lower=0> s_Y;
}

transformed parameters {
  real a[K];
  real b[K];
  for (k in 1:K) {
    a[k] = a0 + ak[k];
    b[k] = b0 + bk[k];
  }
}

model {
  for (k in 1:K) {
    ak[k] ~ normal(0, s_a);
    bk[k] ~ normal(0, s_b);
  }

  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y);
}
