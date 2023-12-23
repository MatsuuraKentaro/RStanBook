library(ggplot2)

d <- read.csv(file='../input/data-attendance-4-2.txt')

d_person <- tapply(d$Y, d$PersonID, mean)
bw <- (max(d_person)-min(d_person))/30
p <- ggplot(data=data.frame(X=d_person), aes(X)) +
  geom_histogram(color='grey20', binwidth=bw) +
  geom_line(aes(y=after_stat(count)*bw), stat='density') +
  labs(x='ratio', y='count')
ggsave(file='fig-ex4-person.png', plot=p, dpi=300, w=4, h=3)


d_course <- tapply(d$Y, d$CourseID, mean)
bw <- (max(d_course)-min(d_course))/30
p <- ggplot(data=data.frame(X=d_course), aes(X)) +
  geom_histogram(color='grey20', binwidth=bw) +
  geom_line(aes(y=after_stat(count)*bw), stat='density') +
  labs(x='ratio', y='count')
ggsave(file='fig-ex4-course.png', plot=p, dpi=300, w=4, h=3)
