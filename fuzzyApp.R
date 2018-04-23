#if (!require('fuzzywuzzyR')) install.packages("fuzzywuzzyR")

library(fuzzywuzzyR)
library(stringr)
library(gtools)


df1 = need_matching
df1 = data.frame(produs1 = df1$nume)
df1$produs1 = as.character(df1$produs1)

df2 = magazine_sept_fuzzy
colnames(df2)[1] = "produs2"
df2$produs2 = as.character(df2$produs2)
df2$pret = as.character(df2$pret)


#pune intr-o lista: scor, nume produs, pret produs
t1 = Sys.time()
lista = list()
for (i in 1:nrow(df1)){
  lista[i] = ""
  for (j in 1:nrow(df2)){
    init = FuzzMatcher$new()
    lista[[i]][j] = paste(init$Token_set_ratio(df1$produs1[i], df2$produs2[j]), df2$produs2[j], df2$pret[j]) #calculeaza scor
  }
}
t2 = Sys.time() - t1
t2
  
lista_copy = lista
t1 = Sys.time()
#sorteaza descrescator produsele dupa scor
lista = lapply(lista, gtools::mixedsort, decreasing = TRUE)
t2 = Sys.time()-t1
t2
#selecteaza primele 4 produse cu scorul cel mai mare
for(i in 1:length(lista)){
  lista[[i]] = lista[[i]][1:6]
}


