data {
  int N;
  int K;
  vector[N] X;
  vector[N] Y;
  int<lower=1, upper=K> KID[N];
  real Nu;
}

parameters {
  vector[2] ab[K];
  vector[2] ab0;
  cholesky_factor_corr[2] corr_chol;
  vector<lower=0>[2] sigma_vec;
  real<lower=0> s_Y;
}

transformed parameters {
  vector[K] a;
  vector[K] b;
  cholesky_factor_cov[2] cov_chol;
  for (k in 1:K) {
    a[k] = ab[k,1];
    b[k] = ab[k,2];
  }
  cov_chol = diag_pre_multiply(sigma_vec, corr_chol);
}

model {
  ab0[1] ~ normal(400, 200);
  ab0[2] ~ normal(15, 15);
  sigma_vec[1] ~ student_t(4, 0, 200);
  sigma_vec[2] ~ student_t(4, 0, 20);
  corr_chol ~ lkj_corr_cholesky(Nu);
  ab ~ multi_normal_cholesky(ab0, cov_chol);
  Y ~ normal(a[KID] + b[KID] .* X, s_Y);
}

generated quantities {
  matrix[2,2] corr;
  matrix[2,2] cov;
  corr = multiply_lower_tri_self_transpose(corr_chol);
  cov = multiply_lower_tri_self_transpose(cov_chol);
}
