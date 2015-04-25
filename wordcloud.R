#load the required packages.
library("twitteR")
library("tm")
library("wordcloud")
library("RColorBrewer")
#You need to authenicate your twitter account for development.
api_key;
api_secret
access_key
access_secret
setup_twitter_oauth(api_key,api_secret,access_key,access_secret)
#Grab 500 tweets with the key word "online education."  
online_tweets = searchTwitter("Online education",n=500, lang = "en")
#Get the text of the tweets
online_text = sapply(online_tweets, function(x) x$getText())
#create a corpus
online_corpus = Corpus(VectorSource(online_text))
#create document term matrix applying some transformations.
tdm = TermDocumentMatrix(online_corpus,control = list(removePunctuation=TRUE, stopwords=c("online","education",stopwords("english")),removeNumbers = TRUE, tolower = TRUE))
#define tdm as matrix
m=as.matrix(tdm)
#get word counts in decreasing order
word_freqs=sort(rowSums(m),decreasing = TRUE)
#create a data frame with words and thier frequencies
dm = data.frame(word=names(word_freqs),freq=word_freqs) 
#plot wordcloud
wordcloud(dm$word,dm$freq,random.order = FALSE,colors = brewer.pal(8,"Dark2"))