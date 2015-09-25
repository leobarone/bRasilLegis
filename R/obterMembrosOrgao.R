obterMembrosOrgao <- function(IDOrgao.param){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterMembrosOrgao?',
                                  query = list(IDOrgao = IDOrgao.param)))
  membros <- xmlToDataFrame(getNodeSet(parsedRequestOutput, "//membros/*"), stringsAsFactors = F)
  membros <- data.frame(comissao = as.character(xpathSApply(parsedRequestOutput, "//orgao", xmlAttrs)), membros)
  return(membros)
}

#obterMembrosOrgao()
# IDOrgao.param = 2004
# obterMembrosOrgao(2001)
