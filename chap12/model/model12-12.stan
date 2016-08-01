data {
  int I;
  int Y[I];
}

parameters {
  vector[I] r;
  real<lower=0> s_r;
}

model {
  target += normal_lpdf(r[3:I] | 2*r[2:(I-1)] - r[1:(I-2)], s_r);
  Y ~ poisson_log(r);
}

generated quantities {
  vector[I] Y_mean;
  Y_mean = exp(r);
}
