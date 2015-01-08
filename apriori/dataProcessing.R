data <- read.csv('result.csv', header = T)
data$transaction_id <-
    paste(data$num_ticket, data$id_client, data$dt_ticket, data$heure,
          sep = '_')
data <- subset(data, select = c(transaction_id, desc_sous_famille))
colnames(data) <- c('transaction_id', 'item_id')
data <- as.data.frame(apply(data, 2, function(x) gsub('\\s+', '', x)))
write.csv(data, 'processedResult.csv', sep = ',', row.names = F)
