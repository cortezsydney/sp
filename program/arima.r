#Rscript --vanilla arima.r ./stat/lakers.csv lakers.txt D
##This code is highly based on
#Dalinina, R. (n.d.). Introduction to Forecasting with ARIMA in R. 
#    Retrieved April 19, 2019, from https://www.datascience.com/blog/introduction-to-forecasting-with-arima-in-r-learn-data-science-tutorials?fbclid=IwAR0eqx_s0IRD2kQ-ByeL2j7HV7I1suQFugVCjZ2SwodQgbTH7hKMlqkFdtY

library('ggplot2')
library('forecast')
library('tseries')
  
args = commandArgs(trailingOnly=TRUE)                     ####
my_data <- read.csv(args[1], header=FALSE, col.names = c("X","Y"))

if (args[3] == "Y"){
  my_data$Date <- my_data$X
}else if(args[3] == "D"){
  my_data$Date <- as.POSIXct(my_data$X, format="%m/%d/%Y")
  my_data$Date <- as.numeric(my_data$Date)
}

#plot the input data
#ggplot(my_data, aes(my_data$Date, my_data$Y)) + 
#  geom_line() + scale_x_date('Date')  + ylab("Results") + xlab("")

#clean data
count_ts = ts(my_data[, 2])
my_data$clean_cnt = tsclean(count_ts)

#plot the cleaned data
#ggplot() + geom_line(data = my_data, aes(x = my_data$Date, y = clean_cnt)) + 
#  ylab('Cleaned Data')


my_data$cnt_ma = ma(my_data$clean_cnt, order=7) # using the clean count with no outliers
my_data$cnt_ma30 = ma(my_data$clean_cnt, order=30)

#ggplot() +
#  geom_line(data = my_data, aes(x = my_data$Date, y = clean_cnt, colour = "Counts")) +
#  geom_line(data = my_data, aes(x = my_data$Date, y = cnt_ma,   colour = "Weekly Moving Average"))  +
#  geom_line(data = my_data, aes(x = my_data$Date, y = cnt_ma30, colour = "Monthly Moving Average"))  +
#  ylab('Count')

#decompose data
count_ma = ts(na.omit(my_data$cnt_ma), frequency=30)
decomp = stl(count_ma, s.window="periodic")
deseasonal_cnt <- seasadj(decomp)                                             ####
plot(decomp)  

#stationary
adf.test(count_ma, alternative = "stationary")

#auto correlations and choosing model order
Acf(count_ma, main='')
Pacf(count_ma, main='')

count_d1 = diff(deseasonal_cnt, differences = 1)
plot(count_d1)
adf.test(count_d1, alternative = "stationary")

Acf(count_d1, main='ACF for Differenced Series')

#find the fit model
model = auto.arima(deseasonal_cnt, seasonal=FALSE)
Pacf(count_d1, main='PACF for Differenced Series')

#forecast using the model
fcast <- forecast(model, h=1)
plot(fcast)
summary(fcast)
order = arimaorder(model)
print(paste0("ARIMA Prediction: ", fcast$mean[1]))

#write results to txt file
res = paste("ARIMA Prediction: ", fcast$mean[1])
write.table(res, file = args[2], append =  TRUE, quote = FALSE, sep = "\t",row.names = FALSE, col.names = FALSE)