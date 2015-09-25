library(httr); library(XML)
obterLideresBancadas <- function(){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterLideresBancadas?'))
  bancada <- as.data.frame(t(xpathSApply(parsedRequestOutput, "//bancada", xmlAttrs)), stringsAsFactors = F)
  names(bancada)[2] <- "nome.bancada"
  output <- data.frame()
  for (i in 1:nrow(bancada)){
    lideres <- xmlToDataFrame(getNodeSet(parsedRequestOutput, paste("//bancada[@sigla = '", bancada$sigla[i], "']/*", sep = '')), stringsAsFactors = F)
    lideres$posicao <- "vice-lider"; lideres$posicao[1] <- "lider"
    lideres[1]
    output <- rbind(output, merge(bancada[i,], lideres))
  }
  return(output)
}

#d<- obterLideresBancadas()
