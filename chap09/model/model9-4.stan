data {
  int N;
  int K;
  int<lower=1, upper=K> Y[N];
}

parameters {
  simplex[K] theta;
}

model {
  for (n in 1:N)
    Y[n] ~ categorical(theta);
}
