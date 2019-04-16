my_data <- read.csv("./poly/followers.csv", header=FALSE, col.names = c("X","Y"))
x <- as.POSIXct(my_data$X, format="%m/%d/%Y")
x <- as.numeric(x)

attach(my_data)
#get summary of your data
summary(my_data)
#then plot your data

plot(x, my_data$Y, main = "Polynomial Regression", las=1)

model <- lm(my_data$Y ~ x)
abline(model, lwd=3, col="red")
testModel <- summary(model)
baseModel = testModel$r.squared
print(baseModel)

temp <- lm(my_data$Y ~ poly(x, degree=2, raw=T))
testTemp <- summary(temp)
baseTemp = testTemp$r.squared

print(baseTemp)

loop = TRUE
count = 2
b = x^count
while(TRUE){
  if (baseModel < baseTemp){
    baseModel = baseTemp
    count = count + 1
    
    temp <- lm(my_data$Y ~ poly(x, degree=count, raw=T))
    testTemp <- summary(temp)
    baseTemp = testTemp$r.squared
    res = testTemp$residuals
    print(baseTemp)
    print(count)
  }else{
    lines(smooth.spline(x, predict(temp)), col="blue", lwd=3)
    break;
  }
}
#statistics by jim making statistics intuitive //multicollinearity (nagkakataon)