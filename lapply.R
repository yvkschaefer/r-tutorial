library(stats)
library(graphics)

x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
lapply(x, mean)
