library(gtools)
library(ggtern)

lab_seq <- seq(from=0.2, to=1, by=0.2)

plot.tern <- function(d, file) {
  p <- ggtern(data=d, aes(x=z, y=y, z=x)) +
    theme_bw(base_size=18, base_family='serif') + theme_latex(value=TRUE) +
    theme(
      plot.margin=margin(-5,-5,-5,-5,'mm'),
      tern.axis.line=element_line(color=gray(0.2)),
      tern.panel.grid.major=element_line(size=0.25, color=gray(0.2)),
      tern.axis.text=element_text(size=14, color=gray(0.4)),
      tern.axis.arrow.show=TRUE,
      tern.axis.arrow=element_line(color='black'),
      tern.axis.arrow.sep=0.13
    ) +
    theme_anticlockwise() + theme_rotate(45) +
    Tlab('', labelarrow='$\\theta_2') +
    Rlab('', labelarrow='$\\theta_1') +
    Llab('', labelarrow='$\\theta_3') +
    scale_T_continuous(breaks=lab_seq, labels=lab_seq) +
    scale_R_continuous(breaks=lab_seq, labels=lab_seq) +
    scale_L_continuous(breaks=lab_seq, labels=lab_seq) +
    geom_point(shape=1)
  ggsave(file=file, plot=p, dpi=300, w=4, h=4)
}

set.seed(123)
N <- 200
alpha <- rep(1, 3)
x <- rdirichlet(N, alpha)
d <- data.frame(x)
colnames(d) <- c('x', 'y', 'z')
plot.tern(d, file='output/fig6-6-left-top.png')

set.seed(123)
N <- 200
alpha <- rep(0.3, 3)
x <- rdirichlet(N, alpha)
d <- data.frame(x)
colnames(d) <- c('x', 'y', 'z')
plot.tern(d, file='output/fig6-6-left-bottom.png')

set.seed(123)
N <- 200
alpha <- c(0.3, 1, 1)
x <- rdirichlet(N, alpha)
d <- data.frame(x)
colnames(d) <- c('x', 'y', 'z')
plot.tern(d, file='output/fig6-6-right-top.png')

set.seed(123)
N <- 200
alpha <- c(3, 6, 6)
x <- rdirichlet(N, alpha)
d <- data.frame(x)
colnames(d) <- c('x', 'y', 'z')
plot.tern(d, file='output/fig6-6-right-bottom.png')
