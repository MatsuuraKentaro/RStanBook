library(rstan)

load('output/result-model4-5.RData')

write.table(data.frame(summary(fit)$summary, check.names=FALSE),
  file='output/fit-summary.csv', sep=',', quote=TRUE, col.names=NA)


library(ggmcmc)
ggmcmc(ggs(fit, inc_warmup=TRUE, stan_include_auxiliar=TRUE),
  file='output/fit-traceplot.pdf', plot='traceplot')
ggmcmc(ggs(fit), file='output/fit-ggmcmc.pdf')


library(coda)
pdf(file='output/fit-traceplot-coda.pdf')
plot(As.mcmc.list(fit))
dev.off()
