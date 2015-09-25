obterPartidosCD <- function() {
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosCD'))
  return(xmlToDataFrame(parsedRequestOutput))
}

#obterPartidosCD()
