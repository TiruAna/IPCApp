library(dplyr)
library(stringr)
carrefour = read.csv("Model_2_codificare_carrefour_august.csv")
cora = read.csv("Model_2_codificare_cora_august.csv")
mega = read.csv("Model_2_codificare_mega_image_august.csv")
nomenclator = read.csv("nomenclator.csv")

clean_codificare = function(data, nomenclator){
  data = data[,c("nume", "pret", "Sortiment")]
  data$nume = as.character(data$nume)
  data$Sortiment = as.integer(as.character(data$Sortiment))
  data = data[!duplicated(data$nume),]
  data = subset(data, !is.na(Sortiment))
  data = left_join(data, nomenclator[,c("cods", "denumire")], by = c("Sortiment"="cods"))
  data = data[,c("nume", "pret", "denumire")]
  colnames(data)[colnames(data) == "denumire"] = "nomenclator"
  data$nomenclator = tolower(data$nomenclator)
  data$nume = tolower(data$nume)
  #eliminare spatii albe duble
  #eliminare virgule etc...
  return(data)
}

carrefour = clean_codificare(carrefour, nomenclator)
cora = clean_codificare(cora, nomenclator)
mega = clean_codificare(mega, nomenclator)

magazine_codificate = rbind(carrefour, cora, mega)
magazine_codificate = magazine_codificate[!duplicated(magazine_codificate$nume),]
magazine_codificate = subset(magazine_codificate, !is.na(nomenclator))

#Clean pret ================================================
clean_pret = function(data){
  data = subset(data, pret != "")
  data$pret = str_extract(data$pret, '\\d+.\\d\\d?')
  data$pret = gsub("\\.", "", data$pret)
  data$pret = as.numeric(data$pret)
  data$pret = data$pret/100
  return(data)
}

magazine_codificate = clean_pret(magazine_codificate)
