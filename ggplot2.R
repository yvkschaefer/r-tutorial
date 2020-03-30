library(ggplot2)

ds <- read.csv("https://github.com/ripberjt/qrmlabs/raw/master/Class%20Data%20Set%20Factored.csv", header = TRUE)

ggplot(ds, aes(age)) +
  geom_histogram()


ggplot(ds) +
  geom_histogram(aes(x=age, y=..density..))


ggplot(ds, aes(age)) +
  geom_histogram(aes(x=age, y=..density..), bins=50) +
  stat_function(fun=dnorm, args = list(mean=mean(ds$age), sd=sd(ds$age)), color="red")
