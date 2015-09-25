listarCargosOrgaosLegislativosCD <- function(){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarCargosOrgaosLegislativosCD?'))
  return(as.data.frame(t(xpathSApply(parsedRequestOutput, "//cargo", xmlAttrs))))
}

#listarCargosOrgaosLegislativosCD()

