set.seed(123)

bernoulli_rng <- sample.int(n=2, size=10, replace=TRUE, prob=c(0.8, 0.2)) - 1
#=> [1] 0 0 0 1 1 0 0 1 0 0

categorical_rng <- sample.int(n=5, size=10, replace=TRUE, prob=c(0.1, 0.2, 0.25, 0.35, 0.1))
#=> [1] 1 3 2 3 4 5 4 4 4 1
