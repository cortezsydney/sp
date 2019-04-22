#Rscript --vanilla poly.r ./stat/lakers.csv
##This code is highly based on
# Statistics, M. R. (2016, July 05). Polynomial Regression in R | R Tutorial 5.12 | MarinStatsLectures. 
#    Retrieved April 12, 2019, from https://www.youtube.com/watch?v=ZYN0YD7UfK4

args = commandArgs(trailingOnly=TRUE)

my_data <- read.csv("./stat/cyclones.csv", header=FALSE, col.names = c("X","Y"))
#x <- as.POSIXct(my_data$X, format="%m/%d/%Y")
#x <- as.numeric(x)

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
dfram <- data.frame('X' = c(my_data$X))
dfram$Y <- c(my_data$Y)
typeof(dfram)

pred <- data.frame('x'=c(5,6))
myFit <- lm(Y ~ poly(X, degree = 2), data=dfram)

new.speed <- data.frame('X'=2018)
myFit
predict(myFit, new.speed)


#24312783
#write results to txt file
#write.table(paste0(args[1], ": ", fcast$mean[1]), file = "forArima.txt", append =  TRUE, sep = "\t",row.names = FALSE, col.names = FALSE)