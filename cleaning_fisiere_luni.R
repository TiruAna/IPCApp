library(stringr)
carrefour_sept = read.csv("20170913carrefour.jsprodusv1.csv")
cora_sept = read.csv("20170906coraprodusv1.csv")
mega_sept = read.csv("20170906m_image.jsprodusv1.csv")

carrefour_oct = read.csv("20171004carrefour.jsprodusv1.csv")
cora_oct = read.csv("20171006coraprodusv1.csv")
mega_oct = read.csv("20171006m_image.jsprodusv1.csv")

carrefour_noi = read.csv("20171101carrefour.jsprodusv1.csv")
cora_noi = read.csv("20171101coraprodusv1.csv")
mega_noi = read.csv("20171101m_image.jsprodusv1.csv")

clean_magazin = function(data){
  data = data[,c("nume", "pret")]
  data$pret = as.factor(data$pret)
  data$nume = as.character(data$nume)
  data$nume = tolower(data$nume)
  data = data[!duplicated(data$nume),]
  return(data)
}

carrefour_sept = clean_magazin(carrefour_sept)
cora_sept = clean_magazin(cora_sept)
mega_sept = clean_magazin(mega_sept)

magazine_sept = rbind(carrefour_sept, cora_sept, mega_sept)
magazine_sept = magazine_sept[!duplicated(magazine_sept$nume),]

carrefour_oct = clean_magazin(carrefour_oct)
cora_oct = clean_magazin(cora_oct)
mega_oct = clean_magazin(mega_oct)

magazine_oct = rbind(carrefour_oct, cora_oct, mega_oct)
magazine_oct = magazine_oct[!duplicated(magazine_oct$nume),]

carrefour_noi = clean_magazin(carrefour_noi)
cora_noi = clean_magazin(cora_noi)
mega_noi = clean_magazin(mega_noi)

magazine_noi = rbind(carrefour_noi, cora_noi, mega_noi)
magazine_noi = magazine_noi[!duplicated(magazine_noi$nume),]

#Clean pret ================================================
clean_pret = function(data){
  data = subset(data, pret != "")
  data$pret = str_extract(data$pret, '\\d+.\\d\\d?')
  data$pret = gsub("\\.", "", data$pret)
  data$pret = as.numeric(data$pret)
  data$pret = data$pret/100
  return(data)
}

magazine_sept = clean_pret(magazine_sept)
magazine_noi = clean_pret(magazine_noi)
magazine_oct = clean_pret(magazine_oct)