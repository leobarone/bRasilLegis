obterDeputados <- function() {
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados?'))
  return(xmlToDataFrame(parsedRequestOutput))
}

#obterDeputados()
