# Uncomment these if they need to be installed
# install.packages("readxl")
# install.packages("openxlsx") 

library(readxl)
library(openxlsx)
library(tidytext)

nrc <- get_sentiments("nrc") ## save nrc dictionary in a df

theheist <- read_excel("theheist.xlsx")

colnames(theheist) <- c("num", 'word', 'count')

# each word gets a column with all sentiments that it has
dfheist <- merge(theheist, nrc, by = "word") 

# words are grouped together then smushed together with each sentiment as a column of NA or 1 
heist_sent <- dfheist %>% 
  group_by(sentiment, word, count) %>% summarise(Freq=n()) %>% spread(sentiment, Freq)

# output to file called finalone.xlsx
write.xlsx(heist_sent, "finalone.xlsx", sheetName="Sheet1", 
           col.names=TRUE, row.names=TRUE, append=FALSE, showNA=TRUE, password=NULL)