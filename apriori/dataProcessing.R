data <- read.csv('result.csv', header = T)

# creates id from composite primary key
data$transaction_id <-
    paste(data$num_ticket, data$id_client, data$dt_ticket, data$heure,
          sep = '_')

# only keeps the transaction id and the item id
data <- subset(data, select = c(transaction_id, desc_sous_famille))
colnames(data) <- c('transaction_id', 'item_id')

# removes leading and trailing spaces from the item id
data <- as.data.frame(apply(data, 2, function(x) gsub('^\\s+|\\s+$', '', x)))

# removes useless items
data <- subset(data, item_id != 'AUTRES' & item_id != 'ACCESSOIRES' &
               item_id != 'SUPP' & item_id != 'H.S' & item_id != 'DIVERS' &
               item_id != 'H.S.' & item_id != 'SUP' & item_id != '***' &
               item_id != 'HS')

write.csv(data, 'processedResult.csv', sep = ',', row.names = F)
