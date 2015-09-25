obterEmendasSubstitutivoRedacaoFinal <- function(tipo.param,
                           numero.param,
                           ano.param){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterEmendasSubstitutivoRedacaoFinal?',
                                      query = list(tipo = tipo.param,
                                                   numero = numero.param,
                                                   ano = ano.param)))
  proposicao <- data.frame(tipo = tipo.param, numero = numero.param, ano = ano.param,
                           tipo.proposicao = xpathSApply(parsedRequestOutput, "//Proposicao/*/*", xmlName),
                           as.data.frame(t(xpathSApply(parsedRequestOutput, "//Proposicao/*/*", xmlAttrs))))
  return(proposicao)
}



# tipo.param="PL"; numero.param=3962; ano.param=2008
# obterEmendasSubstitutivoRedacaoFinal(tipo.param, numero.param, ano.param)
