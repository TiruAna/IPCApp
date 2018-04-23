#if (!require('fuzzywuzzyR')) install.packages("fuzzywuzzyR")

library(fuzzywuzzyR)
library(stringr)

df1 = need_matching
df1 = data.frame(produs1 = df1$nume)
df1$produs1 = as.character(df1$produs1)

df2 = magazine_noi_fuzzy
colnames(df2)[1] = "produs2"
df2$produs2 = as.character(df2$produs2)
df2$pret = as.character(df2$pret)

fuzzy = function(df1, df2){
  t1 = Sys.time()
  lista = list()
  for (i in 1:nrow(df1)){
    lista[i] = 0
    for (j in 1:nrow(df2)){
      init = FuzzMatcher$new()
      lista[[i]][j] = init$Token_set_ratio(df1$produs1[i], df2$produs2[j]) #calculeaza scor
    }
  }
  t2 = Sys.time() - t1
  t2

  # Metoda1 Maximul scorului ========================================================================================
  scor = list()
  for (i in 1:length(lista)){
    scor[i] = 0
    scor[i] = which(max(lista[[i]]) == lista[[i]])[1]
  }

  for(i in 1:length(scor)){
    df1$produs2[i] = df2$produs2[scor[[i]]]
    df1$scor1[i] = max(lista[[i]])
    df1$pret2[i] = df2$pret[scor[[i]]]
  }
  
  # Metoda2 Compara nr de caractere ========================================================================================
  scor = list()
  for (i in 1:length(lista)){
    scor[i] = ""
    for(j in 1:length(lista[[i]])){
      if(max(lista[[i]]) == lista[[i]][j]){
        scor[i] = paste(scor[i], paste(j)) #pozitia unde gaseste maxim
      }
    }
  }

  # sparge siruri de caractere
  for(i in 1:length(scor)){
    scor[i] = str_split(gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", scor[i], perl=TRUE), " ")
  }

  for(i in 1:length(scor)){
    scor[[i]] = as.numeric(scor[[i]])  #transforma din caracter in numeric
  }

  # raportul dintre lungimea sirurilor
  raport = list()
  for(i in 1:length(scor)){
    raport[i] = 0
    for(j in 1:length(scor[[i]])){
      raport[[i]][j] = ifelse(nchar(df1[i,1])>nchar(df2[scor[[i]][j],]),
                              nchar(df1[i,1])/nchar(df2[scor[[i]][j],]),
                              nchar(df2[scor[[i]][j],])/nchar(df1[i,1]))
    }
  }

  #adauga produsul gasit in df1
  #produs1 = produs initial
  #produs3 = produse obtinute cu metoda raportului
  #scor2 = scorul obtinut cu metoda raportului
  for(i in 1:length(raport)){
    df1$produs3[i] = df2$produs2[scor[[i]][which(raport[[i]] == min(raport[[i]]))]]
    df1$scor2[i] = lista[[i]][scor[[i]][which(raport[[i]] == min(raport[[i]]))]]
    df1$pret3[i] = df2$pret[scor[[i]][which(raport[[i]] == min(raport[[i]]))]]
  }
  
  return(df1)
}

df1 = fuzzy(df1, df2)

