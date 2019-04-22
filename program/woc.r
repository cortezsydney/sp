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

#write results to txt file
write.table(paste("WOC Prediction: ", mean(orderedData)), file = args[2], 
            append =  TRUE, quote = FALSE, sep = "\t",row.names = FALSE, col.names = FALSE)
write.table(paste("Normalized Wisdom of the Crowd Prediction: ", ans), file = args[2], 
            append =  TRUE, quote = FALSE, sep = "\t",row.names = FALSE, col.names = FALSE)