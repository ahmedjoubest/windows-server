setwd("C:/Users/Administrator/Desktop/Extraction_donnee")
   
ll <- parse(file = "extraction.R")

for (i in seq_along(ll)) {
  tryCatch(eval(ll[[i]]),
           error = function(e) message("Oops!  ", as.character(e)))
} 