library(dplyr)
group = magazine_codificate %>% group_by(nomenclator) %>% dplyr::summarise(nr = n()) 
x = c(2)
