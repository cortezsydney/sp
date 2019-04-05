library(ggplot2)
my_data <- read.csv("bitcoinHist.csv", header=FALSE, col.names = c("X","Y"))
my_data

theme_set(theme_bw())

pl <- ggplot(my_data) + geom_point(aes(x=my_data$X, y=my_data$Y), size=2, colour="#993399") + 
  xlab("Speed (mph)") + ylab("Stopping distance (ft)")  
print(pl)

#0
attach(my_data)
lm0 <- lm(my_data$Y ~ 1)
mean(my_data$Y)
#pl + geom_hline(yintercept=coef(lm0)[1],size=1, colour="#339900")

#1
lm1 <- lm(my_data$Y ~ my_data$X, data=my_data)
#coef(lm1)
#summary(lm1)
#confint(lm1)
pl  + geom_abline(intercept=coef(lm1)[1],slope=coef(lm1)[2],size=1, colour="#339900")
#par(mfrow = c(1, 2))
#plot(lm1, which=c(1,2))

set.seed(100)
n <- nrow(my_data)
i.training <- sort(sample(n,round(n*0.8)))
my_data.training <- my_data[i.training,]
my_data.test  <- my_data[-i.training,]

pred1a.test <- predict(lm1, newdata=my_data.test)

lm1.training <- lm(my_data$Y ~ my_data$X, data=my_data.training)
pred1b.test <- predict(lm1.training, newdata=my_data.test)

data.frame(my_data, pred1a.test, pred1b.test)
dist.test <- my_data.test$X
