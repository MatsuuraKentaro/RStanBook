data {
  int N;
  int C;
  int I;
  int<lower=0, upper=1> A[N];
  real<lower=0, upper=1> Score[N];
  int<lower=1, upper=N> PID[I];
  int<lower=1, upper=C> CID[I];
  real<lower=0, upper=1> W[I];
  int<lower=0, upper=1> Y[I];
}

parameters {
  real b[4];
  real b_P[N];
  real b_C[C];
  real<lower=0> s_P;
  real<lower=0> s_C;
}

transformed parameters {
  real x_P[N];
  real x_C[C];
  real x_J[I];
  real x[I];
  real q[I];
  for (n in 1:N)
    x_P[n] = b[2]*A[n] + b[3]*Score[n] + b_P[n];
  for (c in 1:C)
    x_C[c] = b_C[c];
  for (i in 1:I) {
    x_J[i] = b[4]*W[i];
    x[i] = b[1] + x_P[PID[i]] + x_C[CID[i]] + x_J[i];
    q[i] = inv_logit(x[i]);
  }
}

model {
  for (i in 1:I)
    Y[i] ~ bernoulli(q[i]);
}
