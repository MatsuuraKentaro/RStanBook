data {
  int K;
  int<lower=0> Y[K];
}

parameters {
  simplex[K] theta;
}

model {
  Y ~ multinomial(theta);
}
