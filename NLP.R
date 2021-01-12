library(wordcloud)
library(NLP)
library(openNLP)
library(readtext)

DATA_DIR <- system.file("~", package = "readtext")

corpus = readtext(paste0(DATA_DIR,'Frankenstein.txt'), encoding = "UTF-8")["text"]
text = as.String(corpus)

sentence_an = Maxent_Sent_Token_Annotator()
word_an = Maxent_Word_Token_Annotator()
person_an = Maxent_Entity_Annotator(kind = "person") #annotate person

text_annotated = NLP::annotate(text, list(sentence_an,word_an,person_an))

annotates <- sapply(text_annotated$features, `[[`, "kind")
people = text[text_annotated[annotates == "person"]]

unique(people)
occurences<-table(unlist(people)) 
occurences

word.cloud=wordcloud(words=names(occurences), freq=occurences, random.order=F)
