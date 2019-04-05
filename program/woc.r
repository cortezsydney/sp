#Rscript --vanilla woc.r ./woc/selenaWOC.csv

args = commandArgs(trailingOnly=TRUE)
my_data <- read.csv(args[1], header=FALSE, col.names = "X")
orderedData <- sort(my_data$X)
ave = sum(as.numeric((orderedData) %/% length(orderedData)))

ans = 0
startIndex = 96
endIndex = 862

for (i in startIndex: endIndex){
  ans = ans + orderedData[i]
}

ans = ans/((endIndex - startIndex) + 1)

print(paste("Result off WOC:", mean(orderedData)))
print(paste("Normalized Result of WOC:", ans))

