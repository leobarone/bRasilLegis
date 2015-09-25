obterOrgaos <- function(){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterOrgaos?'))
  return(as.data.frame(t(xpathSApply(parsedRequestOutput, "//orgao", xmlAttrs))))
}

# o <- obterOrgaos()
# View(o)
