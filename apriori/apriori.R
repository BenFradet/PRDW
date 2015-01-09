library(arules)

transactions <- read.transactions('processedResult.csv', format = 'single',
                                  sep = ',', rm.duplicates = T,
                                  cols = c('transaction_id', 'item_id'))

pngName <- 'freq.png'
png(pngName)
barplot(c(42100, 26444, 19201, 13582, 9306, 7001, 5336, 4139, 3447, 2729, 2258,
          1906, 1630, 1281, 1140, 931, 839, 662, 589, 483, 407, 345, 293, 272,
          221, 229, 183, 176, 135, 132, 109, 93, 114, 96, 71, 77, 69, 57, 65,
          46, 48, 41, 44, 28, 42, 37, 25, 24, 23, 23, 18, 19, 22, 17, 18, 15,
          14, 14, 12, 5, 6, 6, 3, 6, 5, 5, 2, 6, 5, 3, 4, 1, 3, 1, 3, 1, 2, 1,
          3, 1, 1, 1, 1, 2, 1, 2, 2, 1, 2, 1),
        names.arg = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                      18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
                      32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
                      46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
                      60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73,
                      75, 77, 78, 80, 81, 82, 84, 85, 86, 87, 88, 89, 93, 95,
                      96, 102, 103),
        xlab = 'Nombre de produits dans le panier',
        ylab = 'Fréquence',
        main = 'Distribution des tailles de paniers')
dev.off()
cat(pngName, 'sauvegardee\n')

pngName <- 'top10ItemFreq.png'
png(pngName)
itemFrequencyPlot(transactions, topN = 10,
                  xlab = 'Sous famille de produit',
                  ylab = 'Fréquence',
                  main = 'Distribution des 10 produits les plus achetés')
dev.off()
cat(pngName, 'sauvegardee\n')

rules <- apriori(data = transactions,
                 parameter = list(support = 0.02, confidence = 0.25, minlen = 2)
                 )
