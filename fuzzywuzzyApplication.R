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

# concatenate scor, nume, pret =============================
t1 = Sys.time()
lista = list()
for (i in 1:nrow(df1)){
  lista[i] = 0
  for (j in 1:nrow(df2)){
    init = FuzzMatcher$new()
    lista[[i]][j] = paste(init$Token_set_ratio(df1$produs1[i], df2$produs2[j]), df2$produs2[j], df2$pret[j]) #calculeaza scor
  }
}
t2 = Sys.time() - t1
t2

lista_copy = lista

t1 = Sys.time()
listDecrease = list()
for(i in 1:length(lista)){
  listDecrease[[i]] = ""
  listDecrease[[i]] = mixedsort(lista[[i]], decreasing = TRUE)[1:4]
}
Sys.time()-t1

listDecrease_copy = listDecrease

#extragere in 2 coloane pret si scor
l1 = list()
l2 = list()
for(i in 1:length(listDecrease)){
  l1[[i]] = ""
  l2[[i]] = ""
  for(j in 1:length(listDecrease[[i]])){
    l1[[i]][j] = unlist(str_extract_all(listDecrease[[i]][j], "[0-9]+"))[1]
    l2[[i]][j] = str_extract(listDecrease[[i]][j], "\\d+\\.*\\d*$")
    
  }
}


#\\d+\\.\\d+$
for(i in 1:length(listDecrease)){
  for(j in 1:length(listDecrease[[i]])){
    listDecrease[[i]][j] = str_trim(str_replace(listDecrease[[i]][j], "\\d*\\.?\\d*$", ""), "right")
    listDecrease[[i]][j] = str_trim(substring(listDecrease[[i]][j], 4), "left") #remove scor 
    
  }
}

#write lista, listDecrease, l1, l2
saveRDS(lista, "lista")
saveRDS(listDecrease, "listDecrease")
saveRDS(l1, "l1")
saveRDS(l2, "l2")
#read
l1 = readRDS("l1")
l2 = readRDS("l2")
lista = readRDS("lista")
listDecrease = readRDS("listDecrease")

df = need_matching
df = df[,c(1,2)]
colnames(df)[1] = "prod_aug"
colnames(df)[2] = "pret_aug"

df$prod_sept[1:120] = "<select class=\"dropdown-produs\">"
df$prod_sept = as.character(df$prod_sept)


for(i in 1:120){
  for(j in 1:4){
    df$prod_sept[i] = paste0(df$prod_sept[i], "<option value=\"", j, "\">", listDecrease[[i]][j], "</option>")
  }
  df$prod_sept[i] = paste(df$prod_sept[i], "</select>")
}

df$pret_sept[1:120] = "<select class=\"dropdown-pret\">"
df$pret_sept = as.character(df$pret_sept)


for(i in 1:120){
  for(j in 1:4){
    df$pret_sept[i] = paste0(df$pret_sept[i], "<option value=\"", j, "\">", l2[[i]][j], "</option>")
  }
  df$pret_sept[i] = paste(df$pret_sept[i], "</select>")
}

df$scor_aug_sept[1:120] = "<select class=\"dropdown-scor\">"
df$scor_aug_sept = as.character(df$scor_aug_sept)

for(i in 1:120){
  for(j in 1:4){
    df$scor_aug_sept[i] = paste0(df$scor_aug_sept[i], "<option value=\"", j, "\">", l1[[i]][j], "</option>")
  }
  df$scor_aug_sept[i] = paste(df$scor_aug_sept[i], "</select>")
}

# Percent : crestere, scadere pret

percent = list()
for (i in 1:nrow(df)){
  l2[[i]] = as.numeric(l2[[i]])
  percent[[i]] = seq(4)
  for(j in 1:length(l2[[i]])){
    percent[[i]][j] = abs((df$pret_aug[i] - l2[[i]][j])/df$pret_aug[i])
    percent[[i]][j] = as.numeric(format(round(percent[[i]][j],2),2))
  }
}

saveRDS(percent, "percent")

for(i in 1:nrow(df)){
  percent[[i]] = as.character(percent[[i]])
}
df$procent[1:120] = "<select class=\"dropdown-procent\">"
df$procent = as.character(df$procent)
for(i in 1:120){
  for(j in 1:4){
    df$procent[i] = paste0(df$procent[i], "<option value=\"", j, "\">", percent[[i]][j], "</option>")
  }
  df$procent[i] = paste(df$procent[i], "</select>")
}

for(i in 1:nrow(df)){
  df$percent[i] = percent[[i]][1]
}

write.csv(df, "dfShiny.csv")

