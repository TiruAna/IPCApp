
#=========================== SEPTEMBRIE ===========================================================
join_aug_sept = left_join(magazine_codificate, magazine_sept, by = c("nume" = "nume"), copy = TRUE)

colnames(join_aug_sept)[2] = "pret_aug"
colnames(join_aug_sept)[4] = "pret_sept"
join_aug_sept$pret_aug = as.character(join_aug_sept$pret_aug)
join_aug_sept$pret_sept = as.character(join_aug_sept$pret_sept)

#Adauga coloana cu numele produselor din sept, coloana scor
for(i in 1:nrow(join_aug_sept)){
  if(!is.na(join_aug_sept$pret_sept[i])){
    join_aug_sept$nume_sept[i] = join_aug_sept$nume[i]
    join_aug_sept$scor_aug_sept[i] = 101
  }else{
    join_aug_sept$nume_sept[i] = NA
    join_aug_sept$scor_aug_sept[i] = NA
  }
}


need_matching = subset(join_aug_sept, is.na(pret_sept))
#magazine_sept_fuzzy = subset(left_join(magazine_sept, subset(join_aug_sept, !is.na(pret_aug)),
#                                       by = c("nume" = "nume")), is.na(pret_aug))

magazine_sept_fuzzy = anti_join(magazine_sept, subset(join_aug_sept, !is.na(pret_sept)), by = c("nume" = "nume"))


# Append dupa ce am aplicat functia fuzzy
for(i in 1:nrow(join_aug_sept)){
  for(j in 1:nrow(df1)){
    if(join_aug_sept$nume[i] == df1$produs1[j]){
      join_aug_sept$nume_sept[i] = df1$produs3[j]
      join_aug_sept$pret_sept[i] = df1$pret3[j]
      join_aug_sept$scor_aug_sept[i] = df1$scor2[j]
    }else{
      join_aug_sept$nume_sept[i] = join_aug_sept$nume_sept[i]
      join_aug_sept$pret_sept[i] = join_aug_sept$pret_sept[i]
      join_aug_sept$scor_aug_sept[i] = join_aug_sept$scor_aug_sept[i]
    }
  }
}

#=========================== OCTOMBRIE ===========================================================
join_aug_sept = left_join(join_aug_sept, magazine_oct, by = c("nume" = "nume"), copy = TRUE)
colnames(join_aug_sept)[7] = "pret_oct"
join_aug_sept$pret_oct = as.character(join_aug_sept$pret_oct)

#Adauga coloana cu numele produselor din oct, coloana scor
for(i in 1:nrow(join_aug_sept)){
  if(!is.na(join_aug_sept$pret_oct[i])){
    join_aug_sept$nume_oct[i] = join_aug_sept$nume[i]
    join_aug_sept$scor_aug_oct[i] = 101
  }else{
    join_aug_sept$nume_oct[i] = NA
    join_aug_sept$scor_aug_oct[i] = NA
  }
}

need_matching = subset(join_aug_sept, is.na(pret_oct))

magazine_oct_fuzzy = anti_join(magazine_oct, subset(join_aug_sept, !is.na(pret_oct)), by = c("nume" = "nume"))

# Append dupa ce am aplicat functia fuzzy
for(i in 1:nrow(join_aug_sept)){
  for(j in 1:nrow(df1)){
    if(join_aug_sept$nume[i] == df1$produs1[j]){
      join_aug_sept$nume_oct[i] = df1$produs3[j]
      join_aug_sept$pret_oct[i] = df1$pret3[j]
      join_aug_sept$scor_aug_oct[i] = df1$scor2[j]
    }else{
      join_aug_sept$nume_oct[i] = join_aug_sept$nume_oct[i]
      join_aug_sept$pret_oct[i] = join_aug_sept$pret_oct[i]
      join_aug_sept$scor_aug_oct[i] = join_aug_sept$scor_aug_oct[i]
    }
  }
}

#=========================== NOIEMBRIE ===========================================================
join_aug_sept = left_join(join_aug_sept, magazine_noi, by = c("nume" = "nume"), copy = TRUE)
colnames(join_aug_sept)[10] = "pret_noi"
join_aug_sept$pret_noi = as.character(join_aug_sept$pret_noi)

#Adauga coloana cu numele produselor din noi
for(i in 1:nrow(join_aug_sept)){
  if(!is.na(join_aug_sept$pret_noi[i])){
    join_aug_sept$nume_noi[i] = join_aug_sept$nume[i]
    join_aug_sept$scor_aug_noi[i] = 101
  }else{
    join_aug_sept$nume_noi[i] = NA
    join_aug_sept$scor_aug_noi[i] = NA
  }
}

need_matching = subset(join_aug_sept, is.na(pret_noi))

magazine_noi_fuzzy = anti_join(magazine_noi, subset(join_aug_sept, !is.na(pret_noi)), by = c("nume" = "nume"))

# Append dupa ce am aplicat functia fuzzy
for(i in 1:nrow(join_aug_sept)){
  for(j in 1:nrow(df1)){
    if(join_aug_sept$nume[i] == df1$produs1[j]){
      join_aug_sept$nume_noi[i] = df1$produs3[j]
      join_aug_sept$pret_noi[i] = df1$pret3[j]
      join_aug_sept$scor_aug_noi[i] = df1$scor2[j]
    }else{
      join_aug_sept$nume_noi[i] = join_aug_sept$nume_noi[i]
      join_aug_sept$pret_noi[i] = join_aug_sept$pret_noi[i]
      join_aug_sept$scor_aug_noi[i] = join_aug_sept$scor_aug_noi[i]
    }
  }
}

write.csv(join_aug_sept, "matching_fuzzy_final.csv")
