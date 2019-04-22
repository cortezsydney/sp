#Rscript --vanilla poly.r ./stat/lakers.csv ../lakers.txt D
##This code is highly based on
# Statistics, M. R. (2016, July 05). Polynomial Regression in R | R Tutorial 5.12 | MarinStatsLectures. 
#    Retrieved April 12, 2019, from https://www.youtube.com/watch?v=ZYN0YD7UfK4

args = commandArgs(trailingOnly=TRUE)
my_data <- read.csv(args[1], header=FALSE, col.names = c("X","Y"))

if (args[3] == "Y"){
  x <- my_data$X
}else if(args[3] == "D"){
  x <- as.POSIXct(my_data$X, format="%m/%d/%Y")
  x <- as.numeric(x)
}

attach(my_data)
summary(my_data)
plot(x, my_data$Y, main = "Polynomial Regression", las=1)

model1 <- lm(my_data$Y ~ x)
#abline(model, lwd=3, col="red")
baseModel = round(summary(model1)$r.squared, digits = 4)
print(baseModel)

temp <- lm(my_data$Y ~ poly(x, degree=2, raw=TRUE))
baseTemp = round(summary(temp)$r.squared, digits = 4)
print(baseTemp)

count = 2
b = x^count
while(TRUE){
  if (baseModel < baseTemp){
    count = count + 1
    model1 = temp
    baseModel = round(summary(model1)$r.squared, digits = 4)
    
    temp <- lm(my_data$Y ~ poly(x, degree=count, raw = TRUE))
    baseTemp = round(summary(temp)$r.squared, digits = 4)
    print(paste0(baseModel, ": ", count))
  }else{
    summary(model1)
    
    break
  } 
}

dfram
if (args[3] == "Y"){
  dfram <- data.frame('X' = c(my_data$X))
}else if(args[3] == "D"){
  dfram <- data.frame('X' = c(as.numeric(as.POSIXct(my_data$X, format="%m/%d/%Y"))))
}

dfram$Y <- c(my_data$Y)
myFit <- lm(Y ~ poly(X, degree = count), data=dfram)
 lines(smooth.spline(x, predict(myFit)), col = "blue", lwd=3)

new.speed 
if (args[3] == "Y"){
  new.speed <- data.frame('X'=2018)
}else if(args[3] == "D"){
  new.speed <- data.frame('X' = c(as.numeric(as.POSIXct("01/13/2019", format="%m/%d/%Y"))))
}

res1 = predict(myFit, new.speed)

summary(myFit)

#write results to txt file
res = paste("Polynomial Regression Prediction: ", res1)
write.table(res, file = args[2], append =  TRUE, quote = FALSE, sep = "\t",row.names = FALSE, col.names = FALSE)