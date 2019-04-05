my_data <- read.csv("testb.csv", header=FALSE, col.names = c("X","Y"))
x <- as.POSIXct(my_data$X, format="%m/%d/%Y")
x <- as.numeric(x)
attach(my_data)

#get summary of your data
summary(my_data)
#then plot your data
plot(x, my_data$Y, main = "Polynomial Regression", las=1)

#now, lets fit a linear regression
model1 <- lm(my_data$Y ~ x)
summary(model1)
#and add  the line to the plot... make it thick and red
abline(model1, lwd = 3, col="red")

#2nd degree
model2 <- lm(my_data$Y ~ poly(x, degree=2, row=T))
lines(smooth.spline(x, predict(model2)), col="blue", lwd=3)

#3rd degree
b <- x^2
c <- x^3
model3 <- lm(my_data$Y ~ x + b + c)
lines(smooth.spline(x, predict(model3)), col="blue", lwd=3)

#4th degree
d <- b^2
model4 <- lm(my_data$Y ~ x + b + c + d)
lines(smooth.spline(x, predict(model4)), col="yellow", lwd=3)

#4th degree
e <- c^2
model5 <- lm(my_data$Y ~ x + b + c + d + e)
lines(smooth.spline(x, predict(model5)), col="purple", lwd=3)

anova(model2, model3, model4, model5)
#statistics by jim making statistics intuitive //multicollinearity (nagkakataon)