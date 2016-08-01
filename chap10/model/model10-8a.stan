parameters {
  real a;
  vector[1000] r;
}

model {
  a ~ normal(0, 3);
  r ~ normal(0, exp(a/2));
}
