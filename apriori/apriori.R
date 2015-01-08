library(arules)

transactions <- read.transactions('processedResult.csv', format = 'single',
                                  sep = ',', rm.duplicates = T,
                                  cols = c('transaction_id', 'item_id'))
