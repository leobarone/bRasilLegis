obterIntegraComissoesRelator <- function(tipo.param,
                                         numero.param,
                                         ano.param){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterIntegraComissoesRelator?',
                                      query = list(tipo = tipo.param,
                                                   numero = numero.param,
                                                   ano = ano.param)))
  comissao <- data.frame(tipo = tipo.param, numero = numero.param, ano = ano.param,
                         cbind(as.data.frame(t(xpathSApply(parsedRequestOutput, "//comissao", xmlAttrs))),
                               xmlToDataFrame(getNodeSet(parsedRequestOutput,"//comissao"), stringsAsFactors = F)))
  return(comissao)
}

# tipo.param="PL"; numero.param=3962; ano.param=2008
# obterIntegraComissoesRelator(tipo.param, numero.param, ano.param)
