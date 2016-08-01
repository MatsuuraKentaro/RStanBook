data {
  int I;
  int<lower=0, upper=1> A[I];
  real<lower=0, upper=1> Score[I];
  int<lower=1, upper=3> WID[I];
  int<lower=0, upper=1> Y[I];
}

parameters {
  real b[3];
  real bw2;
  real bw3;
}

transformed parameters {
  real bw[3];
  bw[1] = 0;
  bw[2] = bw2;
  bw[3] = bw3;
}

model {
  for (i in 1:I)
    Y[i] ~ bernoulli_logit(b[1] + b[2]*A[i] + b[3]*Score[i] + bw[WID[i]]);
}
