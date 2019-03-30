library(ggplot2)

data(cars)
head(cars)

my_data <- read.csv("bitcoinHist.csv", header=FALSE, col.names = c("X","Y"))
my_data

theme_set(theme_bw())

pl <- ggplot(my_data) + geom_point(aes(x=my_data$X, y=my_data$Y), size=2, colour="#993399") + 
  xlab("Speed (mph)") + ylab("Stopping distance (ft)")  
print(pl)