#source ./venv/bin/activate  # sh, bash, ksh, or zsh
#python3 ./program/cnn.py /program/ai/bitcoin.csv bitcoin.txt

##This code is highly based on
#Brownlee, J. (2018, August 30). How to Get Started with Deep Learning for Time Series Forecasting (7-Day Mini-Course). 
#    Retrieved March 25, 2019, from https://machinelearningmastery.com/how-to-get-started-with-deep-learning-for-time-series-forecasting-7-day-mini-course/

from numpy import array
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Flatten
from keras.layers.convolutional import Conv1D
from keras.layers.convolutional import MaxPooling1D

import csv;
import sys

# define dataset
data = []
windowWidth = 3

with open(sys.argv[1]) as csvfile:                       #opens the csv file
    readCSV = csv.reader(csvfile, delimiter=',')
    for line in readCSV:
        data.append(line[0])                                 #put the read input in time series format x
   
outData = []
arrInData = []
for i in range(len(data) - 2):
    inData = []
    for j in range(windowWidth):
        inData.append(float(data[i+j]))
    outData.append(float(data[i+j]))
    arrInData.append(inData)

X = array(arrInData)                                         #sets up
y = array(outData)


# reshape from [samples, timesteps] sinto [samples, timesteps, features]
X = X.reshape((X.shape[0], X.shape[1], 1))

# define model
model = Sequential()
model.add(Conv1D(filters=64, kernel_size=2, activation='relu', input_shape=(3, 1)))
model.add(MaxPooling1D(pool_size=2))
model.add(Flatten())
model.add(Dense(50, activation='relu'))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mse')

# fit model
model.fit(X, y, epochs=1000, verbose=0)

# demonstrate prediction
x_input = array([y[-3], y[-2], y[-1]])
x_input = x_input.reshape((1, 3, 1)) 
yhat = model.predict(x_input, verbose=0)
print("\n\nCNN Prediction: ",(yhat)[0][0])

f=open(sys.argv[2], "a+")
f.write("CNN Prediction: ")
f.write(format((yhat)[0][0]))
f.write("\n")