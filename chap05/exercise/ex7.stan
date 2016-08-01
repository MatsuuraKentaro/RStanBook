data {
  int I;
  int<lower=0> N[I];
  int<lower=0> Y[I];
  real<lower=0> X[I];
  int<lower=0, upper=1> F[I];
}

parameters {
  real b[3];
}

transformed parameters {
  real q[I];
  for (i in 1:I)
    q[i] = inv_logit(b[1] + b[2]*X[i] + b[3]*F[i]);
}

model {
  for (i in 1:I)
    Y[i] ~ binomial(N[i], q[i]);
}

generated quantities {
  real y_pred[I];
  for (i in 1:I)
    y_pred[i] = binomial_rng(N[i], q[i]);
}
