functions {
  real ZIP_lpmf(int Y, real q, real lambda) {
    if (Y == 0) {
      return log_sum_exp(
        bernoulli_lpmf(0 | q),
        bernoulli_lpmf(1 | q) + poisson_log_lpmf(0 | lambda)
      );
    } else {
      return bernoulli_lpmf(1 | q) + poisson_log_lpmf(Y | lambda);
    }
  }
}

data {
  int N;
  int D;
  int<lower=0> Y[N];
  matrix[N,D] X;
}

parameters {
  vector[D] b[2];
}

transformed parameters {
  vector[N] q_x;
  vector[N] q;
  vector[N] lambda;

  q_x = X*b[1];
  lambda = X*b[2];
  for (n in 1:N)
    q[n] = inv_logit(q_x[n]);
}

model {
  for (n in 1:N)
    Y[n] ~ ZIP(q[n], lambda[n]);
}
