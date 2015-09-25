listarTiposOrgaos <- function(){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarTiposOrgaos?'))
  return(as.data.frame(t(xpathSApply(parsedRequestOutput, "//tipoOrgao", xmlAttrs))))
}

#listarTiposOrgaos()

