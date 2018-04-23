library(stringr)
fuzzy = read.csv("matching_fuzzy_final.csv")

clean_pret = function(data){
  data = subset(data, pret_aug != "" & pret_sept != "" & pret_oct != "" & pret_noi != "")
  data$pret_aug = str_extract(data$pret_aug, '\\d+.\\d\\d?')
  data$pret_sept = str_extract(data$pret_sept, '\\d+.\\d\\d?')
  data$pret_oct = str_extract(data$pret_oct, '\\d+.\\d\\d?')
  data$pret_noi = str_extract(data$pret_noi, '\\d+.\\d\\d?')
  
  data$pret_aug = gsub("\\.", "", data$pret_aug)
  data$pret_sept = gsub("\\.", "", data$pret_sept)
  data$pret_oct = gsub("\\.", "", data$pret_oct)
  data$pret_noi = gsub("\\.", "", data$pret_noi)
  
  data$pret_aug = as.numeric(data$pret_aug)
  data$pret_sept = as.numeric(data$pret_sept)
  data$pret_oct = as.numeric(data$pret_oct)
  data$pret_noi = as.numeric(data$pret_noi)
  
  data$pret_aug = data$pret_aug/100
  data$pret_sept = data$pret_sept/100
  data$pret_oct = data$pret_oct/100
  data$pret_noi = data$pret_noi/100
  return(data)
}

fuzzy = clean_pret(fuzzy)
write.csv(fuzzy[,-c(1)], "matching_fuzzy.csv")
