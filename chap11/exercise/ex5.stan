functions {
  real coin_answer_lpmf(int Y, real q) {
    return log_sum_exp(
        log(0.5) + bernoulli_lpmf(Y | q),
        log(0.5) + bernoulli_lpmf(Y | 1)
    );
  }
}

data {
  int N;
  int<lower=0, upper=1> Y[N];
}

parameters {
  real<lower=0, upper=1> q;
}

model {
  for (n in 1:N)
    Y[n] ~ coin_answer(q);
}
