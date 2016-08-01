data {
  int N;
  int D;
  vector[D] Y[N];
}

parameters {
  vector[D] mn;
  cov_matrix[D] cov;
}

model {
  Y ~ multi_normal(mn, cov);
}
