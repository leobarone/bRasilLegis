obterRegimeTramitacaoDespacho <- function(tipo.param,
                                         numero.param,
                                         ano.param){
  parsedRequestOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterRegimeTramitacaoDespacho?',
                                      query = list(tipo = tipo.param,
                                                   numero = numero.param,
                                                   ano = ano.param)))
  proposicao <- data.frame(tipo = tipo.param, numero = numero.param, ano = ano.param,
                           xmlToDataFrame(getNodeSet(parsedRequestOutput,"//proposicao"), stringsAsFactors = F))
  return(proposicao)
}

# tipo.param="PL"; numero.param=8035; ano.param=2010
# obterRegimeTramitacaoDespacho(tipo.param, numero.param, ano.param)
