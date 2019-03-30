args <- commandArgs(TRUE)
r <- as.double(args[1])
x <- as.double(args[2])

print(x)

my_data <- read.csv("arrivals.csv", header=FALSE, col.names = "X")
orderedData <- sort(my_data$X)

startIndex = 96
endIndex = 862

ave = sum(orderedData) %/% length(orderedData)

ans = 0
for (i in startIndex: endIndex){
  ans = ans + orderedData[i]
}
ans = ans/((endIndex - startIndex) + 1)

print(paste("Result of WOC:", mean(orderedData)))
print(paste("Normalized Result of WOC:", ans))