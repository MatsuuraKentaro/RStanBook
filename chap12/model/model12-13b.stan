data {
  int I;
  int J;
  matrix[I,J] Y;
  int T;
  int<lower=1, upper=T> TID[I,J];
}

parameters {
  matrix[I,J] r;
  real<lower=0> s_r;
  vector[T] beta;
  real<lower=0> s_beta;
  real<lower=0> s_Y;
}

model {
  target += normal_lpdf(
    to_vector(r[1:I, 3:J]) |
    to_vector(2*r[1:I, 2:(J-1)] - r[1:I, 1:(J-2)]),
    s_r
  );
  target += normal_lpdf(
    to_vector(r[3:I, 1:J]) |
    to_vector(2*r[2:(I-1), 1:J] - r[1:(I-2), 1:J]),
    s_r
  );
  beta ~ student_t(6, 0, s_beta);
  to_vector(Y') ~ normal(to_vector(r') + beta[to_array_1d(TID)], s_Y);
}
