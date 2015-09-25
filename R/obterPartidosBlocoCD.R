obterPartidosBlocoCD <- function (idBloco.param = "",
                                  numLegislatura.param = ""){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosBlocoCD?',
                                      query = list(idBloco = idBloco.param,
                                                   numLegislatura = numLegislatura.param)))
  bloco <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//bloco"), stringsAsFactors = F)[,1:5]
  output <- data.frame()

  for (i in 1:nrow(bloco)){
    partidos <- xmlToDataFrame(getNodeSet(parsedRequestOutput,
                                            paste("//bloco[.//idBloco/text() = '",
                                                  bloco$idBloco[i],
                                                  "']//partido",
                                                  sep = "")), stringsAsFactors = F)
    output <- rbind(output, merge(bloco[i,], partidos))
  }
  return(output)
}

#d <- obterPartidosBlocoCD()
