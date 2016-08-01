data {
  int N;  // num of players
  int G;  // num of games
  int<lower=1, upper=N> LW[G,2];  // loser and winner of each game
}

parameters {
  ordered[2] performance[G];
  real b;
}

transformed parameters {
  real mu[N];
  mu[1] = 0;
  mu[2] = b;
}

model {
  for (g in 1:G)
    for (i in 1:2)
      performance[g,i] ~ normal(mu[LW[g,i]], 1);
}
