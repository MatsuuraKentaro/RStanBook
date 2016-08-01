parameters {
  real a_raw;
  vector[1000] r_raw;
}

transformed parameters {
  real a;
  vector[1000] r;
  a = 3.0 * a_raw;
  r = exp(a/2) * r_raw;
}

model {
  a_raw ~ normal(0, 1);
  r_raw ~ normal(0, 1);
}
