data {
  int I;
  int J;
  real Y[I,J];
  int T;
  int<lower=1, upper=T> TID[I,J];
  real S_s_Y;
}

parameters {
  real r[I,J];
  real<lower=0> s_r;
  vector[T] beta;
  real<lower=0> s_beta;
  real<lower=0> s_Y;
}

model {
  for (i in 1:I)
    for (j in 3:J)
      target += normal_lpdf(r[i,j] | 2*r[i,j-1] - r[i,j-2], s_r);
  for (i in 3:I)
    for (j in 1:J)
      target += normal_lpdf(r[i,j] | 2*r[i-1,j] - r[i-2,j], s_r);

  beta ~ student_t(6, 0, s_beta);
  for (i in 1:I)
    for (j in 1:J)
      Y[i,j] ~ normal(r[i,j] + beta[TID[i,j]], s_Y);
  s_Y ~ normal(0, S_s_Y);
}
