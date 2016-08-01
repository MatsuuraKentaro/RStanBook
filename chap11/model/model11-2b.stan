data {
  int N;
  int<lower=0> Y[N];
}

parameters {
  real<lower=0> lambda;
}

model {
  for (n in 1:N)
    Y[n] ~ poisson(lambda*0.5);
}
