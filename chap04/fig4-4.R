library(ggmcmc)

load('output/result-model4-5.RData')

p <- ggs_traceplot(ggs(fit, inc_warmup=TRUE, stan_include_auxiliar=TRUE))
p <- p + theme_bw(base_size=18)
p <- p + scale_colour_manual(values=c('#dcdcdc','#a9a9a9','#696969','#000000'))
p <- p + labs(color='Chain')
ggsave(p, file='output/fig4-4.png', dpi=300, w=7, h=10)
